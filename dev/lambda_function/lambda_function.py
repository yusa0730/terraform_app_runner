import subprocess

def lambda_handler(event, context):
    cmd = subprocess.run(
        "curl https://blog.i-tale.jp/", # ここを適宜修正する
        shell=True,
        capture_output=True,
        text=True,
    )
    print("====> stdout")
    print(cmd.stdout)
    print("====> stderr")
    print(cmd.stderr)
    return
