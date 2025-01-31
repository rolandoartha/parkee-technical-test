import pandas as pd
from glob import glob

# Load all CSV files
files = ["branch_a.csv", "branch_b.csv", "branch_c.csv"]
df = pd.concat([pd.read_csv(f) for f in files])

# Clean Data
df.dropna(subset=['transaction_id', 'date', 'customer_id'], inplace=True)
df['date'] = pd.to_datetime(df['date'])
df.sort_values(by=['transaction_id', 'date'], ascending=[True, False], inplace=True)
df.drop_duplicates(subset='transaction_id', keep='first', inplace=True)

# Calculate total sales per branch
df['total'] = df['quantity'] * df['price']
sales_per_branch = df.groupby('branch')['total'].sum().reset_index()

# Save to CSV
sales_per_branch.to_csv('total_sales_per_branch.csv', index=False)
