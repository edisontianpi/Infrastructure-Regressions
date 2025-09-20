
# LOADING LIBRARIES
import pandas as pd
import statsmodels.api as sm
import statsmodels.formula.api as smf
import matplotlib.pyplot as plt

# IMPORT DATA
df = pd.read_excel("/Users/edisontian/Documents/School/Money and Banking/Thesis/Fred Infrastructure and GDP 2.xls", skiprows=17)


# CHECK COLUMN NAMES
print(df.columns)

# RENAME COLUMNS
df = df.rename(columns={
    'observation_date': 'DATE',
    'GDPC1_PCH': 'GDP',
    'UNRATE_PCH': 'UNEMP',
    'FPCPITOTLZGUSA_PCH': 'CPI',
    'TLHWYCONS_PCH': 'HIGH',
    'G160581A027NBEA_PCH': 'GOVEX',
    'PCU336510336510P_PCH': 'PINDEX',
    'IPUDN23731L200000000_PCH': 'HWORK',
    'TRANSIT_PCH': 'RIDER'
})

# LINEAR MODELS
model_one = smf.ols('GDP ~ HIGH', data=df).fit()
model_two = smf.ols('GDP ~ HIGH + GOVEX', data=df).fit()
model_three = smf.ols('GDP ~ HIGH + GOVEX + PINDEX', data=df).fit()
model_four = smf.ols('GDP ~ HIGH + GOVEX + PINDEX + HWORK', data=df).fit()
model_five = smf.ols('GDP ~ HIGH + GOVEX + PINDEX + HWORK + RIDER', data=df).fit()

# PRINT RESULTS TO CONSOLE
print(model_one.summary())
print(model_two.summary())
print(model_three.summary())

# OPTIONAL: Export to HTML
with open("linear_model_results.html", "w") as f:
    f.write(model_one.summary().as_html())
    f.write(model_two.summary().as_html())
    f.write(model_three.summary().as_html())

# PLOT RESIDUALS
#fig, axes = plt.subplots(1, 3, figsize=(18, 5))

# Model One
#axes[0].scatter(model_one.fittedvalues, model_one.resid)
#axes[0].axhline(y=0, color="#7E9BBC", linestyle='--')
#axes[0].set_title("Residuals vs. Fitted for Model One")
#axes[0].set_xlabel("Fitted Values")
#axes[0].set_ylabel("Residuals")

# Model Two
#axes[1].scatter(model_two.fittedvalues, model_two.resid)
#axes[1].axhline(y=0, color="#7E9BBC", linestyle='--')
#axes[1].set_title("Residuals vs. Fitted for Model Two")
#axes[1].set_xlabel("Fitted Values")
#axes[1].set_ylabel("Residuals")

# Model Three
#axes[2].scatter(model_three.fittedvalues, model_three.resid)
#axes[2].axhline(y=0, color="#7E9BBC", linestyle='--')
#axes[2].set_title("Residuals vs. Fitted for Model Three")
#axes[2].set_xlabel("Fitted Values")
#axes[2].set_ylabel("Residuals")

#plt.tight_layout()
#plt.show()

print(model_one.summary())
print(model_two.summary())
print(model_three.summary())
print(model_four.summary())
print(model_five.summary())

import webbrowser
webbrowser.open("linearmodel_1.html")


from statsmodels.iolib.summary2 import summary_col

results_table = summary_col([model_one, model_two, model_three, model_four, model_five],
                            stars=True,
                            model_names=["Model 1", "Model 2", "Model 3", "Model 4", "Model 5"],
                            info_dict={'R-squared': lambda x: f"{x.rsquared:.3f}",
                                       'No. observations': lambda x: f"{int(x.nobs)}"})

print(results_table)
