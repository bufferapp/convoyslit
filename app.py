import altair as alt
import convoys
import convoys.multi
import convoys.utils
import numpy as np
import pandas as pd
import streamlit as st


@st.cache
def read_data():
    df = pd.read_gbq(query, project_id="buffer-data")
    return df


st.title("ConvoysLit")

"""
### Query

You can query BigQuery in the following form. The query must return at the following fields:
- A `created_at` field
- A `converted_at` field
- A `g` field with the assigned group 

"""

query = st.text_area("Query", height=300)

if st.button("RUN"):
    df = read_data()

    _, groups, (G, B, T) = convoys.utils.get_arrays(
        df, groups="g", created="created_at", converted="converted_at"
    )

    m = convoys.multi.KaplanMeier()
    m.fit(G, B, T)

    t_max = max(1, max(T))
    t = np.linspace(0, t_max, 1000)

    df = pd.DataFrame(index=t)

    for i, group in enumerate(groups):
        j = groups.index(group)
        p_y = m.predict(j, t).T
        df[str(group)] = p_y

    chart = (
        alt.Chart(df.reset_index().melt("index"))
        .mark_line()
        .encode(x="index", y="value", color="variable")
        .interactive()
        .properties(height=600)
        .configure_axis(labelFontSize=20, titleFontSize=20)
        .configure_line(size=5)
    )

    st.altair_chart(chart, use_container_width=True)
