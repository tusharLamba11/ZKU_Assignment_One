snarkjs powersoftau new bn128 14 pot14_0000.ptau -v

snarkjs powersoftau contribute pot14_0000.ptau pot14_0001.ptau --name="First contribution" -v

snarkjs powersoftau prepare phase2 pot14_0001.ptau pot14_final.ptau -v

snarkjs groth16 setup merkle.r1cs pot14_final.ptau merkle_0000.zkey

snarkjs zkey contribute merkle_0000.zkey merkle_0001.zkey --name="Tushar" -v

snarkjs zkey export verificationkey merkle_0001.zkey verification_key.json

snarkjs groth16 prove merkle_0001.zkey witness.wtns proof.json in.json

