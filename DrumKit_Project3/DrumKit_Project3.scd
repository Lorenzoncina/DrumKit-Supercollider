
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
SynthDef("sn", {arg out = 0, amp = 0.1, sinfreq = 180, att = 0.01, rel = 0.2, ffreq = 2000, pan = 0;
	var env, snd1, snd2, sum;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd1 = HPF.ar(
		in: WhiteNoise.ar,
		freq: ffreq,
		mul: env
	);
	snd2 = SinOsc.ar(freq: sinfreq, mul: env);
	sum = snd1 + snd2;
	Out.ar(out, Pan2.ar(sum, pan));
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
	arg amp=0.1, pan=0;
    var snd;
    snd = DC.ar(0);
    snd = snd + (SinOsc.ar(XLine.ar(1500, 800, 0.01)) * Env.perc(0.0005, 0.01, curve: \lin).ar);
    snd = snd + (BPF.ar(Impulse.ar(0) * SampleRate.ir / 48000, 6100, 1.0) * 3.dbamp);
    snd = snd + (BPF.ar(Hasher.ar(Sweep.ar), 300, 0.9) * Env.perc(0.001, 0.02).ar);
    snd = snd + (SinOsc.ar(XLine.ar(472, 60, 0.045)) * Env.perc(0.0001, 0.3, curve: \lin).delay(0.005).ar(2));
    snd = snd.tanh;
    Out.ar(\out.kr(0), Pan2.ar(snd, pan, amp));
}).add;
)
//uncomment ad execute the following line of code if you want to listen to the sound
k = Synth.new("kc");


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

// --- clap_electro --- //

( // MIRIAM [with this sound I would change (with the knob) amplitude and changing value (like 600 instead of 7600, lower values for the low pass filtering) makes a good  effect]
SynthDef("ce", {
    |out = 0, amp = 0.5, pan = 0, dur = 1, value = 7600|
    var env1, env2, snd, noise1, noise2;

    // noise 1 - 4 short repeats
    env1 = EnvGen.ar(
        Env.new(
            [0, 1, 0, 0.9, 0, 0.7, 0, 0.5, 0],
            [0.001, 0.009, 0, 0.008, 0, 0.01, 0, 0.03],
            [0, -3, 0, -3, 0, -3, 0, -4]
        )
    );

    noise1 = WhiteNoise.ar(env1);
    noise1 = HPF.ar(noise1, 600);
    noise1 = LPF.ar(noise1, XLine.kr(7200, 4000, 0.03));
    noise1 = BPF.ar(noise1, 1620, 3);

    // noise 2 - 1 longer single
    env2 = EnvGen.ar(Env.new([0, 1, 0], [0.02, 0.18], [0, -4]), doneAction:2);

    noise2 = WhiteNoise.ar(env2);
    noise2 = HPF.ar(noise2, 1000);
    noise2 = LPF.ar(noise2, value);
    noise2 = BPF.ar(noise2, 1230, 0.7, 0.7);

    snd = noise1 + noise2;
    snd = snd * 2;
    snd = snd.softclip;

    Out.ar(out, Pan2.ar(snd,pan,amp));
}).add;
)
//uncomment ad execute the following line of code if you want to listen to the sound
//c = Synth.new("ce");

// --- tom --- //

(
SynthDef("tom", {
    arg startPitch = 1000, endPitch=60, clickLevel=0.7, pitchRel = 0.11, noiseLevel=1, noiseRel= 0.3;
    var pitchEnv = EnvGen.ar(Env.perc(0.01, pitchRel));

    var clickOsc = SinOsc.ar(pitchEnv*(startPitch-endPitch)+endPitch);
    var clickEnv = EnvGen.ar(Env.perc(0.001, pitchRel))*clickLevel;
    var noiseOsc = PinkNoise.ar();
    var noiseEnv = EnvGen.ar(Env.perc(0.01, noiseRel))*noiseLevel;
    var snd =  noiseOsc * noiseEnv +clickOsc *clickEnv;
    Out.ar(0,Pan2.ar(snd, 0, 1));
}).add;
)
//uncomment ad execute the following line of code if you want to listen to the sound
//t = Synth.new("tom");


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
MIDIClient.sources;

//print the key you are pressing to check if the MIDI sw/hw works
MIDIdef.noteOn(\noteOn, {"pressed key: ".postln});

//use this to get more infos
(
 MIDIdef.noteOn(\noteOn, {
	arg vel, noteNumber, chan, src;
	[vel, noteNumber, chan, src].postln;
});
)


~notes = Array.newClear(128);

(
//assign only the keys you intend to use to a sample
//selectea sample and play a key to assign it
var selected;
w = Window.new(name: "Drum parts mapping", bounds:Rect(100,500,400,100)).front;
~samples = Array.newClear(3);
)


////////// ---- MANUALLY MAPPING A MIDI INSTRUMENT ---- /////////////
(
~notes[36] = "kc";
~notes[51] = "cb";
 MIDIdef.noteOn(\noteOn, {
	arg vel, noteNumber, chan, src;
	Synth.new(~notes[noteNumber], [\amp, vel.linexp(1, 127, 0.01, 0.3)]);//amp ARGUMENT SHOULD BE CONSISTENT ACROSS ALL SynthDefs
});
)






//antonaci's code////////////////////////////////////////////////////////////////////////////////////
(
SynthDef("sik-goo", { |out, freq = 440, formfreq = 100, gate = 0.0, bwfreq = 800;
	var x;
	x = Formant.ar(SinOsc.kr(0.02, 0, 10, freq), formfreq, bwfreq);
	x = EnvGen.kr(Env.adsr, gate, Latch.kr(gate, gate)) * x;
	Out.ar(out, x);
	}).add;
)
x = Synth.new("sik-goo");


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
