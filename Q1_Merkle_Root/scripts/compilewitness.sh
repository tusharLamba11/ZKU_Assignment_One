circom merkle.circom --r1cs --wasm --sym --c

node merkle_js/generate_witness.js merkle_js/merkle.wasm in.json witness.wtns

snarkjs wtns export json witness.wtns witness.json