# Prebuilt HIP/ROCr for locality POC

Built from `rocm-systems` commit `815c970b9e` (`poc/locality-domain-v0.1`) via TheRock install.

HIP version string: **7.18.26442** (libamdhip64).  
Companion ROCr: libhsa-runtime64 **1.22.0**.

## Contents

| Path | Role |
|---|---|
| `lib/libamdhip64.so*` | HIP with `hipExtGetLocalityDomainProperties` / locality alloc |
| `lib/libhsa-runtime64.so*` | ROCr with `hsa_amd_memory_set_locality_domain` |
| `lib/libamd_comgr.so*` | Direct HIP dependency |
| `lib/librocm_kpack.so*` | Direct HIP dependency |
| `lib/librocprofiler-register.so*` | HIP/HSA dependency |
| `lib/libhiprtc*.so*` | Matching HIPRTC (prefer 7.18.26442) |
| `lib/rocm_sysdeps/` | TheRock sysdeps used by HSA/HIP (drm, numa, zstd, …) |

`libhsakmt` is static (`.a`) in this install; no separate `libhsakmt.so`.


## One-time unpack (comgr)

GitHub rejects files &gt;100MB, so `libamd_comgr.so.3.5.0` is stored as xz:

```bash
LOC=$PWD/prebuilt/locality-domain-v0.1
xz -dkf $LOC/lib/libamd_comgr.so.3.5.0.xz   # creates libamd_comgr.so.3.5.0
# symlinks libamd_comgr.so -> .so.3 -> .so.3.5.0 already present
```

## Use (match original `/opt/locality-rocm` layout)

Requires amdgpu **v0.3.1** locality driver and preferably **SPX+NPS2**.

```bash
LOC=$PWD/prebuilt/locality-domain-v0.1
export LD_LIBRARY_PATH=$LOC/lib:$LOC/lib/rocm_sysdeps/lib:${LD_LIBRARY_PATH}
export LD_PRELOAD=$LOC/lib/libhsa-runtime64.so.1:$LOC/lib/libamdhip64.so.7
```

**Do not** preload only the two HIP/HSA libs without putting `$LOC/lib` and
`$LOC/lib/rocm_sysdeps/lib` first on `LD_LIBRARY_PATH`, or the process will
mix container `libamd_comgr` / sysdeps with POC HIP.

Verify:

```bash
ldd $LOC/lib/libamdhip64.so   # should resolve under $LOC/lib...
```
