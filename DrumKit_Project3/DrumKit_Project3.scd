
s.boot;
//s.quit;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////--- SYNTH BANK ---/////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

(
// --- bass drum --- //

SynthDef.new("bd", {
    arg  n=0.76966457366943, nl = 0.016062397956848, start=63.017123937607, end=1, l1=0.094613754749298, l2=0.72694784402847, exp=2;
    var boom;
	e = pow(Line.ar(0.9,0,l2, doneAction: 2),exp);//2="freeSelf" ==> frees enclosing synth

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
	var noiseEnv = EnvGen.ar(Env.perc(0.01, noiseRel), doneAction: 2);
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
    var clickEnv = EnvGen.ar(Env.perc(0.001, pitchRel))*clickLevel;
    var noiseOsc = PinkNoise.ar();
    var noiseEnv = EnvGen.ar(Env.perc(0.01, noiseRel), doneAction: 2)*noiseLevel;
    var snd = clickOsc *clickEnv + noiseOsc * noiseEnv;
    Out.ar(0,Pan2.ar(snd, 0, 1));
}).add;
)

//uncomment ad execute the following line of code if you want to listen to the sound
//n = Synth.new("sn");

// --- cowbell --- //
(
SynthDef("cb", {
    | out=0, amp=0.3, gate=1, fund_freq=540, pan=0.0 |
    var sig, env, hash;

    // hash = DC.ar(0);
    hash = BPF.ar(
        Hasher.ar(Sweep.ar(rate: TRand.kr(1.0, 10.0))),
        fund_freq * 1.4,
        0.5,
        2
    ).tanh * Env.perc(0.001, 0.02).ar(0);
    sig = Pulse.ar( fund_freq * [ 1, 1.5085 ], [ 0.565, 0.445 ], [ 0.4, 0.6 ] ).atan;
    env = EnvGen.ar(
            Env(
                [ 0, 0.05, 1, 0.1, 0 ], [ 0.003, 0.002, 0.05, 0.5 ], [2, -4, -4, -4]
            ),
        gate: gate,
        timeScale: [ 1.0, 1.5 ],
        doneAction: 2
        );
    sig = Mix( (hash + sig) * env );
    sig = BPF.ar( sig, fund_freq * 2, 1.808 );

    Out.ar( out, Pan2.ar( sig, pan, amp ) );
}).add;
)
//uncomment ad execute the following line of code if you want to listen to the sound
//c = Synth.new("cb");


// --- kick --- //
(
SynthDef("kc", {
    var snd;
    snd = DC.ar(0);
    snd = snd + (SinOsc.ar(XLine.ar(1500, 800, 0.01)) * Env.perc(0.0005, 0.01, curve: \lin).ar);
    snd = snd + (BPF.ar(Impulse.ar(0) * SampleRate.ir / 48000, 6100, 1.0) * 3.dbamp);
    snd = snd + (BPF.ar(Hasher.ar(Sweep.ar), 300, 0.9) * Env.perc(0.001, 0.02).ar);
    snd = snd + (SinOsc.ar(XLine.ar(472, 60, 0.045)) * Env.perc(0.0001, 0.3, curve: \lin).delay(0.005).ar(2));
    snd = snd.tanh;
    Out.ar(\out.kr(0), Pan2.ar(snd, \pan.kr(0), \amp.kr(0.1)));
}).add;
)
//uncomment ad execute the following line of code if you want to listen to the sound
//k = Synth.new("kc");


// --- frequencymodulator --- //
(
SynthDef("fm", {
	|
	amp=0.2,
	fc=1000,
	fm = 100,
	idx = 100,
	atk=0.01,
	rls=0.1
	|
	var env = EnvGen.ar(Env.perc(atk, rls), doneAction:2);
	var modulator = SinOsc.ar(fm);
	var carrier = SinOsc.ar(fc + (idx*modulator) );
	var sig = carrier *  env * amp;
	sig = HPF.ar(sig, 1000);
	Out.ar(0, sig!2);
}).add;
)
//uncomment ad execute the following line of code if you want to listen to the sound
//f = Synth.new("fm");


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// connection Supercollider <--> OSC <--> Processing ///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////// Supercollider <--> GUI ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

(
w = Window.new(name: "DRUM KIT", bounds:Rect(100,500,400,100)).front;
a = Button.new(w,Rect(10,10,80,80));
a.string = "bass drum";
b = Button.new(w,Rect(110,10,80,80));
b.string = "hi-hat";
c = Button.new(w,Rect(210,10,80,80));
c.string = "snare";
d = Button.new(w,Rect(310,10,80,80));
d.string = "cowbell";


a.mouseDownAction = {
	var bass_drum;
	bass_drum = Synth(\bd);
};


b.mouseDownAction = {
	var hit_hat;
	hit_hat = Synth(\hh);
};


c.mouseDownAction = {
	var snare;
	snare = Synth(\sn);
};


d.mouseDownAction = {
	var cowbell;
	cowbell = Synth(\cb);
};

)







////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////// connection Supercollider <--> MIDI <--> JUCE/// ///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// connection Supercollider <--> MIDI input sw/hw //////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

MIDIClient.init;

MIDIIn.connectAll;

//check the available midi sources
//MIDIClient.sources;

//print the key you are pressing to check if the MIDI sw/hw works
//MIDIdef.noteOn(\noteOn, {"pressed key: ".postln});

//use this to get more infos
/* MIDIdef.noteOn(\noteOn, {
	arg noteNumber, vel, chan, src;
	[noteNumber, vel, chan, src].postln;
});*/


~notes = Array.newClear(128);

//assign only the keys you intend to use to a sample
//selectea sample and play a key to assign it
var selected;
w = Window.new(name: "Drum parts mapping", bounds:Rect(100,500,400,100)).front;
~samples = Array.newClear(3);







//antonaci's code////////////////////////////////////////////////////////////////////////////////////
(
SynthDef("sik-goo", { |out, freq = 440, formfreq = 100, gate = 0.0, bwfreq = 800;
	var x;
	x = Formant.ar(SinOsc.kr(0.02, 0, 10, freq), formfreq, bwfreq);
	x = EnvGen.kr(Env.adsr, gate, Latch.kr(gate, gate)) * x;
	Out.ar(out, x);
	}).add;
)
x = Synth("sik-goo");


(
~noteOn = {
				arg src, chan, num, vel;
				x.set(\freq, num.midicps / 4.0);
				x.set(\gate, vel / 200 );
				x.set(\formfreq, vel / 127 * 1000);
			};
MIDIIn.addFuncTo(\noteOn, ~noteOn);


~noteOff = {
			arg src,chan,num,vel;
			x.set(\gate, 0.0);
			};
MIDIIn.addFuncTo(\noteOff, ~noteOff);


~bend = {
			arg src,chan,val; //(val * 0.048828125).postln;
			x.set(\bwfreq, val * 0.048828125 );
		};
MIDIIn.addFuncTo(\bend, ~bend);
)


//cleanup
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
MIDIIn.removeFuncFrom(\noteOff, ~noteOff);
MIDIIn.removeFuncFrom(\bend, ~bend);

//////////////////////////////////////////////////////////////////////////////////////////////////////////








MIDIdef.freeAll;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
