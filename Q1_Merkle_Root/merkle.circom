pragma circom 2.0.0;


include "mimcsponge.circom";

 //Template to generate hash of 2 leaves using MiMCSponge.
template hash()
{
    signal input in1,in2;
    signal output out;
    component comp = MiMCSponge(2,220,1);
   
    comp.ins[0] <== in1;
    comp.ins[1] <== in2;
    comp.k <== 0;
   
 
    out <== comp.outs[0];
}

//Template to generate the root of the merkle tree
template Merkle_Root(N) {
    signal input leaves[N];
    signal output out;
    component hashes[N-1];

    //This loop is used for assigning the value of leaves to components(i.e. hashes)
    for (var i = 0; i < N / 2; i++) {
        hashes[i + N/2 - 1] = hash();
        hashes[i + N/2 - 1].in1 <== leaves[2*i];
        hashes[i + N/2 - 1].in2 <== leaves[2*i + 1];
    }

    //This for loop is used for generating the root of the merkle tree by using outputs of the hash components generated in the previous for loop. 
    for (var j = N/2 - 2 ; j >= 0 ; j--) {
        hashes[j] = hash();
        hashes[j].in1 <== hashes[2*j + 1].out;
        hashes[j].in2 <== hashes[2*j + 2].out;
    }
     
    //This is the final merkle root.
    out <== hashes[0].out;
}


component main {public [leaves]} = Merkle_Root(8);
