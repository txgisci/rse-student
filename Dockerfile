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
    # jupyter serverextension enable --py jupyterlab --sys-prefix && \
    # The nbgrader extensions create_assignment, formgrader and course_list are disabled for students 
    jupyter nbextension disable --sys-prefix create_assignment/main && \
    jupyter nbextension disable --sys-prefix formgrader/main --section=tree && \
    jupyter serverextension disable --sys-prefix nbgrader.server_extensions.formgrader && \
    jupyter nbextension disable --sys-prefix course_list/main --section=tree && \
    jupyter serverextension disable --sys-prefix nbgrader.server_extensions.course_list && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER && \
    mkdir -p /srv/nbgrader/exchange && \
    fix-permissions /srv/nbgrader/exchange

COPY global_nbgrader_config.py /etc/jupyter/nbgrader_config.py

USER jovyan
