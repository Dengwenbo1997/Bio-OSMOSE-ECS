# Bio-OSMOSE-ECS
Raw simulation outputs from the Bio-OSMOSE-ECS model, including historical baseline and future climate scenarios (SSP1-2.6 and SSP5-8.5), supporting the analyses presented in the associated manuscript.

## Directory structure

```text
osmose_run/
  Base/
  SSP1-2.6/
  SSP5-8.5/
  calibrar_ecs_osmose/
```

The historical scenario, future scenarios and model calibration files are grouped under `osmose_run`. Their internal directory structures are unchanged.

The root-level `ecs_osmose_run.R` uses the historical scenario configuration in `osmose_run/Base/master`.
