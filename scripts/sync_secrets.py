import requests
from dotenv import dotenv_values
from base64 import b64encode, b64decode
import nacl.public

# Charger les secrets
env_secrets = dotenv_values(".env")
env_secrets_local = dotenv_values(".env.local")

# Configuration
try:
    GITHUB_TOKEN = env_secrets_local["GITHUB_TOKEN"]
    GITHUB_REPO = env_secrets_local["GITHUB_REPO"]
except KeyError as e:
    print(f"Erreur: {e} manquant dans .env.local")
    exit(1)

headers = {
    "Authorization": f"token {GITHUB_TOKEN}",
    "Accept": "application/vnd.github+json",
}

def get_public_key():
    url = f"https://api.github.com/repos/{GITHUB_REPO}/actions/secrets/public-key"
    r = requests.get(url, headers=headers)
    r.raise_for_status()
    return r.json()

def put_secret(name, value, public_key, key_id):
    public_key_bytes = b64decode(public_key)
    sealed_box = nacl.public.SealedBox(nacl.public.PublicKey(public_key_bytes))
    encrypted_value = sealed_box.encrypt(value.encode())
    encrypted_value_b64 = b64encode(encrypted_value).decode()

    url = f"https://api.github.com/repos/{GITHUB_REPO}/actions/secrets/{name}"
    payload = {
        "encrypted_value": encrypted_value_b64,
        "key_id": key_id,
    }
    r = requests.put(url, headers=headers, json=payload)
    r.raise_for_status()
    print(f"✅ Secret mis à jour : {name}")

if __name__ == "__main__":
    public_key_data = get_public_key()
    public_key = public_key_data["key"]
    key_id = public_key_data["key_id"]

    for name, value in env_secrets.items():
        if name == "GITHUB_TOKEN" or name == "GITHUB_REPO":
            print(f"⚠️ Ignored secret {name} (réservé par GitHub)")
            continue
        put_secret(name, value, public_key, key_id)
