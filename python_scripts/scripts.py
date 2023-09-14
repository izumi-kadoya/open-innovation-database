import sys
import openai
import os

# APIキーの取得
api_key = os.environ.get("OPENAI_API_SECRET_KEY")
if not api_key:
    print("API key is not set!")
    sys.exit(1)

# コマンドライン引数の確認
if len(sys.argv) < 2:
    print("Please provide a URL as an argument.")
    sys.exit(1)

url = sys.argv[1]

openai.api_key = api_key

try:
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[{"role":"system","content":"You are a professional assistant."},
                  {"role":"user", "content":f"describe this startup. {url}"}]
    )
    print(response["choices"][0]["message"]["content"])
except Exception as e:
    print(f"Error: {e}")
