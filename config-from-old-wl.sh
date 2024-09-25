#!/bin/bash

cd

NUM_WL=$(wc -l < $HOME/wl_formated.txt)

if ! grep -q "export NUM_WL=" ~/.bash_profile; then
    echo "export NUM_WL=$NUM_WL" >> ~/.bash_profile
fi

source ~/.bash_profile

mkdir -p allora_backup
mv $HOME/allora-huggingface-walkthrough/wl* $HOME/allora_backup/

# Doc file wl_formated.txt va tao cac file cau hinh
i=1
while IFS='|' read -r address mnemonic; do
    cat <<EOF > $HOME/allora-huggingface-walkthrough/wl_${i}_config.json
{
    "wallet": {
        "addressKeyName": "wl${i}",
        "addressRestoreMnemonic": "${mnemonic}",
        "alloraHomeDir": "",
        "gas": "1000000",
        "gasAdjustment": 1.5,
        "nodeRpc": "https://allora-rpc.testnet.allora.network/",
        "maxRetries": 2,
        "delay": 1,
        "submitTx": true
    },
    "worker": [
        {
            "topicId": 1,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 15,
            "parameters": {
            "InferenceEndpoint": "http://inference:8000/inference/{Token}",
            "Token": "ETH"
            }
        },
        {
            "topicId": 3,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 15,
            "parameters": {
            "InferenceEndpoint": "http://inference:8000/inference/{Token}",
            "Token": "BTC"
            }
        },
        {
            "topicId": 5,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 15,
            "parameters": {
            "InferenceEndpoint": "http://inference:8000/inference/{Token}",
            "Token": "SOL"
            }
        },
        {
            "topicId": 7,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 5,
            "parameters": {
                "InferenceEndpoint": "http://inference:8000/inference/{Token}",
                "Token": "ETH"
            }
        },
        {
            "topicId": 8,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 5,
            "parameters": {
                "InferenceEndpoint": "http://inference:8000/inference/{Token}",
                "Token": "BNB"
            }
        },
        {
            "topicId": 9,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 5,
            "parameters": {
                "InferenceEndpoint": "http://inference:8000/inference/{Token}",
                "Token": "ARB"
            }
        },
        {
            "topicId": 10,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 5,
            "parameters": {
                "InferenceEndpoint": "http://inference:8000/inference/{BlockHeight}",
                "BlockHeight": "sys.argv[2]"
            }
        },
        {
            "topicId": 11,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 5,
            "parameters": {
                "InferenceEndpoint": "http://inference:8000/inference/topic11/{Team}",
                "Team": "R"
            }
        }
    ]
}
EOF
    i=$((i+1))
done < $HOME/wl_formated.txt
