#!/bin/bash

dfx identity use minter-ian
export MINTER_ACCOUNT_ID=$(dfx ledger account-id)

export TOKEN_NAME="LionQueen"
export TOKEN_SYMBOL="LQ"

dfx identity use DevIan
export DEPLOY_ID=$(dfx identity get-principal)

export PRE_MINTED_TOKENS=10_000_000_000
export TRANSFER_FEE=10_000

dfx identity new archive_controller_ian
dfx identity use archive_controller_ian
export ARCHIVE_CONTROLLER=$(dfx identity get-principal)
export TRIGGER_THRESHOLD=2000
export NUM_OF_BLOCK_TO_ARCHIVE=1000
export CYCLE_FOR_ARCHIVE_CREATION=10000000000000

export FEATURE_FLAGS=false

dfx deploy icrc1_ledger_canister --specified-id mxzaz-hqaaa-aaaar-qaada-cai --argument "(variant {Init =
record {
     token_symbol = \"${TOKEN_SYMBOL}\";
     token_name = \"${TOKEN_NAME}\";
     minting_account = record { owner = principal \"${MINTER}\" };
     transfer_fee = ${TRANSFER_FEE};
     metadata = vec {};
     feature_flags = opt record{icrc2 = ${FEATURE_FLAGS}};
     initial_balances = vec { record { record { owner = principal \"${DEPLOY_ID}\"; }; ${PRE_MINTED_TOKENS}; }; };
     archive_options = record {
         num_blocks_to_archive = ${NUM_OF_BLOCK_TO_ARCHIVE};
         trigger_threshold = ${TRIGGER_THRESHOLD};
         controller_id = principal \"${ARCHIVE_CONTROLLER}\";
         cycles_for_archive_creation = opt ${CYCLE_FOR_ARCHIVE_CREATION};
     };
 }
})"
# ./did.sh && dfx generate token_test && dfx deploy token_test  # Command for deploying canister one locally