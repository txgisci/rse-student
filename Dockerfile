ARG BASE_CONTAINER=jupyter/tensorflow-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Nate Currit <currit@txstate.edu>"

USER root

# Install packages used in 7316
RUN conda install -c conda-forge --quiet --yes \
    'nbgrader' \
    'rasterio' \
    'matplotlib' \
    'bokeh' \
    'geopandas' \
    'rasterstats' \
    'folium' \
    'rise' && \
    jupyter serverextension enable --py jupyterlab --sys-prefix && \
    # jupyter nbextension install --sys-prefix --py nbgrader --overwrite && \
    # jupyter nbextension enable --sys-prefix --py nbgrader && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER && \
    mkdir -p /srv/nbgrader/exchange && \
    fix-permissions /srv/nbgrader/exchange

COPY global_nbgrader_config.py /etc/jupyter/nbgrader_config.py

USER jovyan
