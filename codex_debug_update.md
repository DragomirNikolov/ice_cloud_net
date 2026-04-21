# Evaluation Debug Update

Updated `src/evaluate/EvaluateModel.ipynb` to make `run_evaluation(...)` failures easier to trace back to the source NetCDF patch.

## What Changed

- `create_inference_data(...)` now stores patch ids from the dataloader:
  - `patch_id_data`: one patch id per evaluated sample
  - `profile_patch_id_data_list`: patch ids expanded to match the extracted DARDAR/profile rows

- `get_profile_data(...)` now records the patch ids corresponding to the most recently selected profile subset.

- Added helper functions:
  - `format_patch_id_for_debug(...)`
  - `get_profile_patch_ids_for_debug(...)`
  - `print_evaluation_exception_context(...)`

- Wrapped `run_evaluation(...)` in a simple exception handler that:
  - prints the original exception type and message
  - checks `y_hat` and `dardar` for non-finite values
  - checks for values that would be invalid for the configured log transform
  - prints likely source files as `date`, `patch`, and `file`
  - re-raises the original exception so the normal traceback remains available

Example debug output:

```text
run_evaluation failed_day: ValueError: ...
y_hat has suspicious values in 3 profile rows
Possible source patch files:
- date=2010_01_20, patch=99, file=2010_01_20/patch_99.nc
```

## How To Use

Rerun the notebook cells that define the updated functions, then rerun `create_inference_data(...)` before rerunning the failing `run_evaluation(...)` calls. Existing `eval_data` objects created before this update will not contain the new patch-id mapping.

The day/night calls are mapped from the `suffix`, so suffixes like `day`, `night`, `nice_day`, and `nice_night` print patch ids from the matching profile subset.
