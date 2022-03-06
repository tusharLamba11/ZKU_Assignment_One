pragma circom 2.0.0;

include "mimcsponge.circom";

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

template Merkle_Root(N) {
    signal input leaves[N];
    signal output out;
    component hashes[N-1];

    
    for (var i = 0; i < N / 2; i++) {
        hashes[i + N/2 - 1] = hash();
        hashes[i + N/2 - 1].in1 <== leaves[2*i];
        hashes[i + N/2 - 1].in2 <== leaves[2*i + 1];
    }

    
    for (var j = N/2 - 2 ; j >= 0 ; j--) {
        hashes[j] = hash();
        hashes[j].in1 <== hashes[2*j + 1].out;
        hashes[j].in2 <== hashes[2*j + 2].out;
    }

    out <== hashes[0].out;
}


component main {public [leaves]} = Merkle_Root(8);