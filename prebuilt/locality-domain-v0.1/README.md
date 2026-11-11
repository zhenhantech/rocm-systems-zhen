# Prebuilt HIP/ROCr for locality POC

Built from `rocm-systems` commit `815c970b9efeb4d304a445762e9ee44767beedbb` (`poc/locality-domain-v0.1`) via TheRock install.

## Contents

| File | Role |
|---|---|
| `lib/libamdhip64.so*` | HIP runtime with `hipExtGetLocalityDomainProperties` / locality alloc |
| `lib/libhsa-runtime64.so*` | ROCr with `hsa_amd_memory_set_locality_domain` |

## Use

Requires the matching **amdgpu v0.3.1** locality driver (`zhenhantech/amdgpu`, tag `v0.3.1-mtype-fix`) and preferably **SPX+NPS2**.

```bash
export LD_LIBRARY_PATH=$PWD/prebuilt/locality-domain-v0.1/lib:${LD_LIBRARY_PATH}
# Prefer these libs ahead of /opt/rocm/lib
```

Rebuild from source if kernel/ROCm ABI on the host does not match this build.
