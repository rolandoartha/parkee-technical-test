import requests
import pandas as pd

def fetch_universities(country):
 url = f"http://universities.hipolabs.com/search?country={country.replace(' ', '%20')}"
 response = requests.get(url)
 data = response.json()
 df = pd.DataFrame(data)
 df = df[['name', 'web_pages', 'country', 'domains', 'state-province']]
 df = df[df['state-province'].notna()]
 return df

# Example usage
df = fetch_universities("United States")
df.to_csv("universities.csv", index=False)
