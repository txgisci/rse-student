ARG BASE_CONTAINER=jupyter/tensorflow-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Nate Currit <currit@txstate.edu>"

# Install packages used in 7316
RUN conda install -c conda-forge --quiet --yes \
    'nbgrader' \
    'rasterio' \
    'matplotlib' \
    'bokeh' \
    'geopandas' \
    'rasterstats' \
    'matplotlib' \
    'folium' \
    'rise' && \
    jupyter serverextension enable --py jupyterlab --sys-prefix && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
