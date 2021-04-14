# YA-GO-Client

Golang Rest binding for High Level Api, generated by [Open Api Generator](https://github.com/OpenAPITools/openapi-generator/) and several patches.

## Prerequisites
- Golang >= 1.11

## How to generate

Type and hit to `make setup`, that's it.

Note: Be sure you cleaned around with `make clean` before generating over again.

## Run test

TBD

## Need more patching?

Run `make setup`.

Then copy content of `src` into `target` (yes replace them all), then do your changes under `src`. 

When you done with your changes, run;
```bash
./build-scripts/diff-module.sh COMPONENT_NAME > patches/COMPONENT_NAME/00X_PATCH_TITLE.patch
```
where;

- COMPONENT_NAME: (activity | market | payment) depend on component you patch
- PATCH_TITLE: give a descriptive title to your patch
- 00X: order number of patch