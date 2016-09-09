## Dockerfile for Radiant

DiD: MIRACLE Docker image to wrap [`Radiant` business analytics tool](http://radiant-rstats.github.io/docs/) developed by Vincent Nijs.

This uses a customized version of radiant, available at [radiant-mod](https://github.com/warmdev/radiant-mod)

### Usage

```
sudo docker run -d --name radiant -p <exposed-port-or-remove>:3838 -v {host_data_folder}:/srv/shiny-server/data comses/miracle-radiant
```

`Radiant` will be live at `http://radiant:3838/radiant/inst/base`. Replace `base` with `quant`, `analytics` or `marketing` for other `Radiant` apps. See https://github.com/radiant-rstats/radiant for details.


### FAQ
`n_distinct` and `na.rm` related errors on the visualization page is due to older versions of dependencies (especially the `dplyr` package). In this case, force rebuilding the Docker image should solve the problem.
