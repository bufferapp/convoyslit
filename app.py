import numpy as np
import pandas as pd
import convoys

import streamlit as st
from matplotlib import pyplot
from convoys import utils as cu
from convoys import plotting as cp

st.title("ConvoysLit")

query = st.text_area("Query", height=500)

df = pd.read_gbq(query, project_id="buffer-data")

fig, ax = pyplot.subplots()

_, groups, (G, B, T) = convoys.utils.get_arrays(
    df, groups="g", created="created_at", converted="converted_at"
)

convoys.plotting.plot_cohorts(G, B, T, model="kaplan-meier", groups=groups, ax=ax)

st.pyplot(fig)