
s.boot;
//s.quit;

(
// --- bass drum --- //

SynthDef.new("bd", {
    arg  n=0.76966457366943, nl = 0.016062397956848, start=63.017123937607, end=1, l1=0.094613754749298, l2=0.72694784402847, exp=2;
    var boom;
	e = pow(Line.ar(0.9,0,l2, doneAction: freeSelf),exp);//freeSelf ==> frees enclosing synth

    boom = BBandPass.ar(WhiteNoise.ar(),freq:Line.ar(100,10,nl))*Line.ar(1,0,nl)*n+
    SinOsc.ar(Line.ar(start, end, l1))*e;
    Out.ar(0,[boom,boom])

}).add;

)

//uncomment ad execute the following line of code if you want to listen to the sound
//b = Synth.new("bd")

/*** IMPORTANT: make sure envelopes inside SynthDefs have a defined doneAction argument that ensures
that a wanted action happens when the envelope is over, otherwise the synth simply sits in the Server outputting 0s at audio rate and if you assign a Synth.new to the same variable
you cannot even free it manually anymore. -Mattia***/

// If you want to see what synths are active at any moment on the server uncomment and run the following line.
//s.plotTree;

// ---hi hat --- //
(
SynthDef("hh", {
    arg noiseRel = 0.25380977392197, noiseLevel=0.18370378851891, ffreq=9853, q=0.59219532012939;
    var noiseOsc = BBandPass.ar(PinkNoise.ar(), ffreq, q);
	var noiseEnv = EnvGen.ar(Env.perc(0.01, noiseRel), doneAction: freeSelf);
    var snd = noiseOsc * noiseEnv * 1.4;
    Out.ar(0,Pan2.ar(snd, 0, 1));
}).add;
)

//uncomment ad execute the following line of code if you want to listen to the sound
//h = Synth.new("hh");



// --- snare drum --- //

(
SynthDef("sn", {
    arg startPitch = 7000, endPitch=294, clickLevel=0.11299884319305, pitchRel = 0.03270231127739, noiseLevel=0.75628386735916, noiseRel= 0.40486946344376;
    var pitchEnv = EnvGen.ar(Env([startPitch,410,endPitch],[0.005,0.01], curve:\exp));
    var clickOsc = SinOsc.ar(pitchEnv);
    var clickEnv = EnvGen.ar(Env.perc(0.001, pitchRel), doneAction)*clickLevel;
    var noiseOsc = PinkNoise.ar();
    var noiseEnv = EnvGen.ar(Env.perc(0.01, noiseRel), doneAction: freeSelf)*noiseLevel;
    var snd = clickOsc *clickEnv + noiseOsc * noiseEnv;
    Out.ar(0,Pan2.ar(snd, 0, 1));
}).add;
)

//uncomment ad execute the following line of code if you want to listen to the sound
//n = Synth.new("sn");




////////////////////////////////////////////////////////////////////////////////
///////////////// connect Supercollider with Processing ////////////////////////
////////////////////////////////////////////////////////////////////////////////

NetAddr("127.0.0.1", 57120);



// the bass drum is played when the square is clicked
(
var bass_drum;

//bass_drum = Synth(\bd);

OSCdef('OSCreceiver', {

	arg msg;
	var number_of_clicks, clicks = 0;

	number_of_clicks = msg[1];

	postln("clicks = " + number_of_clicks);

	//bass_drum.play;
	bass_drum = Synth(\bd);

}, "/click");
)





