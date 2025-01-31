import pandas as pd
from datetime import datetime

def process_store_data():
    try:
        # Read the CSV files
        branch_a = pd.read_csv('branch_a.csv')
        branch_b = pd.read_csv('branch_b.csv')
        branch_c = pd.read_csv('branch_c.csv')
        
        # Combine all dataframes
        combined_df = pd.concat([branch_a, branch_b, branch_c], ignore_index=True)
        
        # Clean the data
        # 1. Remove rows with NaN in specified columns
        cleaned_df = combined_df.dropna(subset=['transaction_id', 'date', 'customer_id'])
        
        # 2. Convert date column to datetime
        cleaned_df['date'] = pd.to_datetime(cleaned_df['date'])
        
        # 3. Remove duplicates based on transaction_id, keeping the latest date
        cleaned_df = cleaned_df.sort_values('date').drop_duplicates(
            subset=['transaction_id'], 
            keep='last'
        )
        
        # 4. Calculate total sales per branch
        # Calculate total sales (quantity * price) for each transaction
        cleaned_df['total_sale'] = cleaned_df['quantity'] * cleaned_df['price']
        
        # Group by branch and sum the total sales
        total_sales = cleaned_df.groupby('branch')['total_sale'].sum().reset_index()
        
        # Save to CSV
        total_sales.to_csv('total_sales_per_branch.csv', index=False)
        
        print("Data processing completed successfully!")
        print("Results saved to 'total_sales_per_branch.csv'")
        
    except Exception as e:
        print(f"An error occurred: {str(e)}")

if __name__ == "__main__":
    process_store_data()
