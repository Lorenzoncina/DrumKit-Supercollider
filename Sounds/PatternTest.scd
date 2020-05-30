s.boot;
s.quit;

s.plotTree;


p.stop;

~bpm = 128;

(
SynthDef(\kick3, {
	arg pan=0, amp=0.1;
    var snd;
    snd = DC.ar(0);
    snd = snd + (SinOsc.ar(XLine.ar(1500, 800, 0.01)) * Env.perc(0.0005, 0.01, curve: \lin).ar);
    snd = snd + (BPF.ar(Impulse.ar(0) * SampleRate.ir / 48000, 6100, 1.0) * 3.dbamp);
    snd = snd + (BPF.ar(Hasher.ar(Sweep.ar), 300, 0.9) * Env.perc(0.001, 0.02).ar);
    snd = snd + (SinOsc.ar(XLine.ar(472, 60, 0.045)) * Env.perc(0.0001, 0.3, curve: \lin).delay(0.005).ar(2));
    snd = snd.tanh;
    Out.ar(0, Pan2.ar(snd, pan, amp));
}).add;
)

(
SynthDef(\snare909,{ |out=0,mul=1,velocity=1, amp=0.8|
	var excitation, membrane;

	excitation = LPF.ar(WhiteNoise.ar(1), 7040, 1) * (0.1 + velocity);
	membrane = (
		/* Two simple enveloped oscillators represent the loudest resonances of the drum membranes */
		(LFTri.ar(330,0,1) * EnvGen.ar(Env.perc(0.0005,0.055),doneAction:0) * 0.25)
		+(LFTri.ar(185,0,1) * EnvGen.ar(Env.perc(0.0005,0.075),doneAction:0) * 0.25)

		/* Filtered white noise represents the snare */
		+(excitation * EnvGen.ar(Env.perc(0.0005,0.4),doneAction:2) * 0.2)
		+(HPF.ar(excitation, 523, 1) * EnvGen.ar(Env.perc(0.0005,0.283),doneAction:0) * 0.2)

	) * mul;
	Out.ar(out, (membrane*amp)!2)
}).add;
)


(
Pdef(\kickpat,
	Pbind(
		\instrument, \kick3,
		\dur, Pseq([1/4, 1/4, 1/4, 3/16, 1/16], inf),
		\stretch, 60/~bpm * 4,
		\amp, 0.3!4++[0.003],
	)
).play(quant:60/~bpm * 4)//.quant_(60/~bpm * 4) --> this will wait until next measure to execute changes to the Pdef
)

Pdef(\kickpat).stop;

(
Pdef(\snarepat,
	Pbind(
		\instrument, \snare909,
		\dur, Pseq([Rest(1/4), 1/4, Rest(1/4), 1/4], inf),
		\stretch, 60/~bpm * 4,
		\velocity,1.4,
		\mul, 0.3,
		\amp, 4,
	)
).play(quant:60/~bpm * 4);//quant_(60/~bpm * 4)
)

Pdef(\snarepat).stop;

(
SynthDef(\hihat, {arg out = 0, amp = 0.5, att = 0.01, rel = 0.2, ffreq = 6000, pan = 0;
	var env, snd;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd = WhiteNoise.ar;
	snd = HPF.ar(in: snd, freq: ffreq, mul: env);
	Out.ar(out, Pan2.ar(snd, pan));
}).add;
)

(
Pdef(\hhpat,
	Pbind(
		\instrument, \hihat,
		\dur, Pseq((1/16!2)++[1/8], inf),
		\stretch, 60/~bpm * 4,
		\rel, Pseq((0.1!2)++[0.5], inf),
		\amp, Pseq((0.5!2)++[0.8], inf),
	)
).play(quant:60/~bpm * 4);
)

Pdef(\hhpat).stop;

s.meter;