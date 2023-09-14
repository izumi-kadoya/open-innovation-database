import openai
import os

def fetch_description(url):
    # APIキーの取得
    api_key = os.environ.get("OPENAI_API_SECRET_KEY")
    if not api_key:
        return "API key is not set!"

    openai.api_key = api_key

    try:
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role":"system", "content":"You are a professional assistant."},
                {"role":"user", "content":f"describe this startup. {url}"}
            ]
        )
        return response["choices"][0]["message"]["content"]
    except Exception as e:
        return f"Error: {e}"
