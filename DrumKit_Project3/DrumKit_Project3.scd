
s.boot;
//s.quit;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////--- SYNTH BANK ---/////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// --- bass drum --- //
(
SynthDef.new("bd", {
    arg  n=0.76966457366943, nl = 0.016062397956848, start=63.017123937607, end=1, l1=0.094613754749298, l2=0.72694784402847, exp=2, amp=0.1;
    var boom;
	e = pow(Line.ar(0.9,0,l2, doneAction: 2),exp);//2="freeSelf" ==> frees enclosing synth

    boom = BBandPass.ar(WhiteNoise.ar(),freq:Line.ar(100,10,nl))*Line.ar(1,0,nl)*n+
    SinOsc.ar(Line.ar(start, end, l1))*e;
	boom = boom*amp;
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
    arg noiseRel = 0.25380977392197, noiseLevel=0.18370378851891, ffreq=9853, q=0.59219532012939, amp=0.3;
    var noiseOsc = BBandPass.ar(PinkNoise.ar(), ffreq, q);
	var noiseEnv = EnvGen.ar(Env.perc(0.01, noiseRel), doneAction: 2);
    var snd = noiseOsc * noiseEnv * 6*amp;
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
	arg amp=0.1, pan=0, start=472;
    var snd;
    snd = DC.ar(0);
    snd = snd + (SinOsc.ar(XLine.ar(1500, 800, 0.01)) * Env.perc(0.0005, 0.01, curve: \lin).ar);
    snd = snd + (BPF.ar(Impulse.ar(0) * SampleRate.ir / 48000, 6100, 1.0) * 3.dbamp);
    snd = snd + (BPF.ar(Hasher.ar(Sweep.ar), 300, 0.9) * Env.perc(0.001, 0.02).ar);
    snd = snd + (SinOsc.ar(XLine.ar(start, 60, 0.045)) * Env.perc(0.0001, 0.3, curve: \lin).delay(0.005).ar(2));
    snd = snd.tanh;
    Out.ar(\out.kr(0), Pan2.ar(snd, pan, amp));
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

// --- clap_electro --- //

(
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
    arg startPitch = 1000, endPitch=60, clickLevel=0.7, pitchRel = 0.11, noiseLevel=1, noiseRel= 0.3, amp=0.1;
    var pitchEnv = EnvGen.ar(Env.perc(0.01, pitchRel));

    var clickOsc = SinOsc.ar(pitchEnv*(startPitch-endPitch)+endPitch);
    var clickEnv = EnvGen.ar(Env.perc(0.001, pitchRel))*clickLevel;
    var noiseOsc = PinkNoise.ar();
    var noiseEnv = EnvGen.ar(Env.perc(0.01, noiseRel), doneAction:2)*noiseLevel;
    var snd =  noiseOsc * noiseEnv +clickOsc *clickEnv;
	snd = snd*amp;
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
~n1 = NetAddr.new("127.0.0.1", 12000);


// the bass drum is played when the square is clicked
(
var bass_drum;
var r;
var lst_syn = ['\bd','\hh','\sn','\cb','\kc','\fm'];
OSCdef('OSCreceiver', {

	arg msg;
	//var number_of_clicks, clicks = 0;
	var click_stype = -1;
	// from processing listener -> osc -> synth
	click_stype = msg[1];
	postln("Received click_stype = " + click_stype);
	bass_drum  = Synth(lst_syn[click_stype]);
	// send osc message back to processing
	// change color and return back to p5
	~colors = {rrand(0,255)}!3;
	~n1.sendMsg('/changeColor',~colors[0],~colors[1],~colors[2]);
	~n1.sendMsg('/sendSoundDes',bass_drum);
}, "/click");
)

// -----start of motion OSC receiver from iphone, using Syntien
// represent right hand stick,iphone 1
(
// this is the right hand of the drum stick
var drum;
var lst_syn = ['\bd','\hh','\sn','\cb','\kc','\fm','\ce','\tom'];
OSCdef('Osc1',{
	// prevent multiple stroke
	arg msg;
	x = msg[1];//acceleration on x axis
	y = msg[2];//y
	z = msg[3];//z
	if((x <= -5 )&& (y >= 5 )&& (z >= 5 )){ drum  = Synth(lst_syn[3])};
	if((x <= -5 )&& (y <= -5 )&& (z >= 5 )){ drum  = Synth(lst_syn[4])};
	if((x <= -5 )&& (y >= 5 )&& (z <= -5)){ drum  = Synth(lst_syn[5])};
	/*if((x <= -5 )&& (y <= -5 )&& (z <= -5)){ drum  = Synth(lst_syn[3])};
	if((x >= 5 )&& (y >= 5 )&& (z >= 5)){ drum  = Synth(lst_syn[4])};
	if((x >= 5 )&& (y >= 5 )&& (z <= -5)){ drum  = Synth(lst_syn[5])};
	if((x >= 5 )&& (y <= -5) && (z >= 5)){ drum  = Synth(lst_syn[6])};
	if((x >= 5) && (y <= -5) && (z <= -5)){ drum  = Synth(lst_syn[7])};*/
},"/accel/1");
)

(
// this is the right hand of the drum stick,iphone 2
var drum;
var lst_syn = ['\bd','\hh','\sn','\cb','\kc','\fm','\ce','\tom'];
OSCdef('Osc2',{
	// prevent multiple stroke
	arg msg;
	x = msg[1];//acceleration on x axis
	y = msg[2];//y
	z = msg[3];//z
	postln("Received:"+x,y,z);
	if((x >= 5) && (y >= 5) && (z >= 5) ){ drum  = Synth(lst_syn[0])};
	if((x >= 5) && (y <= -5) && (z >= 5) ){ drum  = Synth(lst_syn[1])};
	if((x >= 5) && (y >= 5) && (z <= -5)){ drum  = Synth(lst_syn[2])};
	//if((x >= 5) && (y <= -5) && (z <= -5)){ drum  = Synth(lst_syn[3])};
	//if((x <= -5) && (y >= 5) && (z >= 5)){ drum  = Synth(lst_syn[4])};
	//if((x <= -5) && (y >= 5) && (z <= -5)){ drum  = Synth(lst_syn[5])};
	//if((x <= -5) && (y <= -5) && (z >= 5)){ drum  = Synth(lst_syn[6])};
	//if((x <= -5) && (y <= -5) && (z <= -5)){ drum  = Synth(lst_syn[7])};
},"/accel/2");
)




//--------- JUCE--->SC OSC COMMUNICATION -------/////
/////////////////////////////////////////////////////


//Volume knobs
(
OSCdef(\volume,{
	arg msg, time, addr, port;
	var vol, synth, x;
	vol = msg[1];
	synth = msg[2];
	switch(synth,
		\bd, {~amp_bd_temp = vol.linexp(0, 1, 0.01, 1);},
		\hh, {~amp_hh_temp = vol.linexp(0, 1, 0.01, 3);},
		\sn, {~amp_sn_temp = vol.linexp(0, 1, 0.01, 0.7);},
		\cb, {~amp_cb_temp = vol.linexp(0, 1, 0.01, 3);},
		\kc, {~amp_kc_temp = vol.linexp(0, 1, 0.01, 1.5);},
		\fm, {~amp_fm_temp = vol.linexp(0, 1, 0.01, 3);},
		\ce, {~amp_clap_e_temp = vol.linexp(0, 1, 0.01, 3.5);},
		\tom, {~amp_tom_temp = vol.linexp(0, 1, 0.01, 3);}
	)
},
'/amp'
);
)


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


s.plotTree;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////// Supercollider <--> GUI ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

(
var bd, hh, sn, cb, kc, fm, ce, tom, knob_names, buttons4keys;
var bd_knobs, hh_knobs, sn_knobs, cb_knobs, kc_knobs, fm_knobs, ce_knobs, tom_knobs;
~l1_temp; ~start_temp; ~amp_bd_temp; ~q_temp; ~ffreq_hh_temp; ~amp_hh_temp; ~sinfreq_temp; ~ffreq_sn_temp; ~amp_sn_temp;
~sinfreq_temp; ~fundfreq_temp; ~amp_cb_temp; ~start_temp; ~amp_kc_temp; ~fc_temp; ~amp_fm_temp; ~value_temp;
~amp_clap_e_temp; ~pitchRel_temp; ~startPitch_temp; ~amp_tom_temp; ~keys2synth;


knob_names = Array2D.new(8, 3);
buttons4keys = Array.newClear(8);
~keys2synth = Array.newClear(8);

w = Window.new(name: "DRUM KIT", bounds:Rect(100,220,810,500)).front;


s.meter;//SHOW THE LEVELS: helps to set the volumes w/o clipping

///////////////////////////////////// bass drum ///////////////////////////////////////
bd = Button.new(w,Rect(15,10,80,80));
bd.string = "bass drum";
buttons4keys[0] = Button.new(w,Rect(15,400,80,80));
buttons4keys[0].string = "assign";

buttons4keys[0].mouseDownAction = {
	v = Window.new(name: "press a key to save it", bounds:Rect(500, 500,500,100)).front;
	t = StaticText(v,Rect(200,10,500,50)).string_("BASS DRUM");
	v.view.keyDownAction = {
		arg view, char, modifiers, unicode, keycode;
		[char, keycode].postln;
		~keys2synth[0] = keycode;
		};
};

w.view.keyDownAction = {
	arg view, char, modifiers, unicode, keycode;
	var bass_drum;

	if(keycode == ~keys2synth[0]){
		bass_drum = Synth(\bd, [\l1,~l1_temp, \start, ~start_temp, \amp, ~amp_bd_temp]);
	}

};

bd.mouseDownAction = {
	var bass_drum;
	bass_drum = Synth(\bd, [\l1,~l1_temp, \start, ~start_temp, \amp, ~amp_bd_temp]);
};
bd_knobs = Array.newClear(3);

bd_knobs[0] = Knob(w,Rect(15,100,80,80));
bd_knobs[0].value = 0.094/2.5; //from the proportion: x/1 = 0.094/2.5
bd_knobs[0].action = {~l1_temp = bd_knobs[0].value.linlin(0, 1, 0, 2.5);
						postln(~l1_temp);
					};
knob_names[0,0] =  StaticText(w,Rect(50,170,90,30)).string_("L 1");

bd_knobs[1] = Knob(w,Rect(15,200,80,80));
bd_knobs[1].value = 63/500;
bd_knobs[1].action = {~start_temp = bd_knobs[1].value.linlin(0, 1, 0, 500);
						postln(~start_temp);
					};
knob_names[0,1] =  StaticText(w,Rect(45,170+100,90,30)).string_("START");

bd_knobs[2] = Knob(w,Rect(15,300,80,80));
bd_knobs[2].value = 0.1/3;
bd_knobs[2].action = {~amp_bd_temp = bd_knobs[2].value.linexp(0, 1, 0.01, 3);
						postln(~amp_bd_temp);
					};
knob_names[0,2] =  StaticText(w,Rect(45,170+200,90,30)).string_("AMP");


///////////////////////////////////// hit hat ///////////////////////////////////////
hh = Button.new(w,Rect(115,10,80,80));
hh.string = "hi-hat";
buttons4keys[1] = Button.new(w,Rect(115,400,80,80));
buttons4keys[1].string = "assign";


buttons4keys[1].mouseDownAction = {
	v = Window.new(name: "press a key to save it", bounds:Rect(500, 500,500,100)).front;
	t = StaticText(v,Rect(200,10,500,50)).string_("HIT HAT");
	v.view.keyDownAction = {
		arg view, char, modifiers, unicode, keycode;
		[char, keycode].postln;
		~keys2synth[1] = keycode;
		};
};

w.view.keyDownAction = {
	arg view, char, modifiers, unicode, keycode;
	var hit_hat;

	if(keycode == ~keys2synth[1]){
		hit_hat = Synth(\hh, [\q, ~q_temp, \ffreq, ~ffreq_hh_temp, \amp, ~amp_hh_temp]);
	}

};


hh.mouseDownAction = {
	var hit_hat;
	hit_hat = Synth(\hh, [\q, ~q_temp, \ffreq, ~ffreq_hh_temp, \amp, ~amp_hh_temp]);
};
hh_knobs = Array.newClear(3);

hh_knobs[0] = Knob(w,Rect(115,100,80,80));
hh_knobs[0].value = 0.59/5;
hh_knobs[0].action = {~q_temp = hh_knobs[0].value.linlin(0, 1, 0, 5);
						postln(~q_temp);
					}; //changes the bandwidth of the noiseOsc
knob_names[1,0] =  StaticText(w,Rect(50+100,170,90,30)).string_("Q");

hh_knobs[1] = Knob(w,Rect(115,200,80,80));
hh_knobs[1].value = 9853/15000;
hh_knobs[1].action = {~ffreq_hh_temp = hh_knobs[1].value.linlin(0, 1, 100, 15000);
						postln(~ffreq_hh_temp);
					};
knob_names[1,1] =  StaticText(w,Rect(45+100,170+100,90,30)).string_("F FREQ");

hh_knobs[2] = Knob(w,Rect(115,300,80,80));
hh_knobs[2].value = 0.3/3;
hh_knobs[2].action = {~amp_hh_temp = hh_knobs[2].value.linexp(0, 1, 0.01, 3);
						postln(~amp_hh_temp);
					};
knob_names[1,2] =  StaticText(w,Rect(50+100,170+200,90,30)).string_("AMP");




///////////////////////////////////// snare ///////////////////////////////////////
sn = Button.new(w,Rect(215,10,80,80));
sn.string = "snare";
buttons4keys[2] = Button.new(w,Rect(215,400,80,80));
buttons4keys[2].string = "assign";


buttons4keys[2].mouseDownAction = {
	v = Window.new(name: "press a key to save it", bounds:Rect(500, 500,500,100)).front;
	t = StaticText(v,Rect(200,10,500,50)).string_("SNARE");
	v.view.keyDownAction = {
		arg view, char, modifiers, unicode, keycode;
		[char, keycode].postln;
		~keys2synth[2] = keycode;
		};
};

w.view.keyDownAction = {
	arg view, char, modifiers, unicode, keycode;
	var snare;

	if(keycode == ~keys2synth[2]){
		snare = Synth(\sn, [\sinfreq, ~sinfreq_temp, \ffreq, ~ffreq_sn_temp, \amp, ~amp_sn_temp]);
	}

};


sn.mouseDownAction = {
	var snare;
	snare = Synth(\sn, [\sinfreq, ~sinfreq_temp, \ffreq, ~ffreq_sn_temp, \amp, ~amp_sn_temp ]);
};
sn_knobs = Array.newClear(3);

sn_knobs[0] = Knob(w,Rect(215,100,80,80));
sn_knobs[0].value = 180/1000;
sn_knobs[0].action = {~sinfreq_temp = sn_knobs[0].value.linlin(0, 1, 0, 1000);
						postln(~sinfreq_temp);
					};
knob_names[2,0] =  StaticText(w,Rect(30+200,170,90,30)).string_("SIN FREQ");

sn_knobs[1] = Knob(w,Rect(215,200,80,80));
sn_knobs[1].value = 2000/5000;
sn_knobs[1].action = {~ffreq_sn_temp = sn_knobs[1].value.linlin(0, 1, 100, 5000);
						postln(~ffreq_sn_temp);
					};
knob_names[2,1] =  StaticText(w,Rect(45+200,170+100,90,30)).string_("F FREQ");

sn_knobs[2] = Knob(w,Rect(215,300,80,80));
sn_knobs[2].value = 0.1/2;
sn_knobs[2].action = {~amp_sn_temp = sn_knobs[2].value.linexp(0, 1, 0.01, 2);
						postln(~amp_sn_temp);
					};
knob_names[2,2] =  StaticText(w,Rect(50+200,170+200,90,30)).string_("AMP");



///////////////////////////////////// cowbell ///////////////////////////////////////
cb = Button.new(w,Rect(315,10,80,80));
cb.string = "cowbell";
buttons4keys[3] = Button.new(w,Rect(315,400,80,80));
buttons4keys[3].string = "assign";


buttons4keys[3].mouseDownAction = {
	v = Window.new(name: "press a key to save it", bounds:Rect(500, 500,500,100)).front;
	t = StaticText(v,Rect(200,10,500,50)).string_("COWBELL");
	v.view.keyDownAction = {
		arg view, char, modifiers, unicode, keycode;
		[char, keycode].postln;
		~keys2synth[3] = keycode;
		};
};

w.view.keyDownAction = {
	arg view, char, modifiers, unicode, keycode;
	var cowbell;

	if(keycode == ~keys2synth[3]){
		cowbell = Synth(\cb, [\fund_freq, ~fundfreq_temp, \amp, ~amp_cb_temp]);
	}

};


cb.mouseDownAction = {
	var cowbell;
	cowbell = Synth(\cb, [\fund_freq, ~fundfreq_temp, \amp, ~amp_cb_temp]);
};
cb_knobs = Array.newClear(2);

cb_knobs[0] = Knob(w,Rect(315,100,80,80));
cb_knobs[0].value = 540/1000;
cb_knobs[0].action = {~fundfreq_temp = cb_knobs[0].value.linlin(0, 1, 30, 1000);
						postln(~fundfreq_temp);
					};
knob_names[3,0] =  StaticText(w,Rect(30+300,170,90,30)).string_("FUND FREQ");

cb_knobs[1] = Knob(w,Rect(315,300,80,80));
cb_knobs[1].value = 0.3/3;
cb_knobs[1].action = {~amp_cb_temp = cb_knobs[1].value.linexp(0, 1, 0.01, 3);
						postln(~amp_cb_temp);
					};
knob_names[3,1] =  StaticText(w,Rect(50+300,170+200,90,30)).string_("AMP");



///////////////////////////////////// kick ///////////////////////////////////////
kc = Button.new(w,Rect(415,10,80,80));
kc.string = "kick";
buttons4keys[4] = Button.new(w,Rect(415,400,80,80));
buttons4keys[4].string = "assign";


buttons4keys[4].mouseDownAction = {
	v = Window.new(name: "press a key to save it", bounds:Rect(500, 500,500,100)).front;
	t = StaticText(v,Rect(200,10,500,50)).string_("KICK");
	v.view.keyDownAction = {
		arg view, char, modifiers, unicode, keycode;
		[char, keycode].postln;
		~keys2synth[4] = keycode;
		};
};

w.view.keyDownAction = {
	arg view, char, modifiers, unicode, keycode;
	var kick;

	if(keycode == ~keys2synth[4]){
		kick = Synth(\kc, [\start, ~start_temp, \amp, ~amp_kc_temp]);
	}

};


kc.mouseDownAction = {
	var kick;
	kick = Synth(\kc, [\start, ~start_temp, \amp, ~amp_kc_temp]);
};
kc_knobs = Array.newClear(2);

kc_knobs[0] = Knob(w,Rect(415,100,80,80));
kc_knobs[0].value = 472/2000;
kc_knobs[0].action = {~start_temp = kc_knobs[0].value.linlin(0, 1, 40, 2000);
						postln(~start_temp);
					};
knob_names[4,0] =  StaticText(w,Rect(30+400,170,90,30)).string_("START FREQ");

kc_knobs[1] = Knob(w,Rect(415,300,80,80));
kc_knobs[1].value = 0.1/2;
kc_knobs[1].action = {~amp_kc_temp = kc_knobs[1].value.linexp(0, 1, 0.01, 2);
						postln(~amp_kc_temp);
					};
knob_names[4,1] =  StaticText(w,Rect(50+400,170+200,90,30)).string_("AMP");



/////////////////////////////////////// fm //////////////////////////////////////////
fm = Button.new(w,Rect(515,10,80,80));
fm.string = "fm";
buttons4keys[5] = Button.new(w,Rect(515,400,80,80));
buttons4keys[5].string = "assign";


buttons4keys[5].mouseDownAction = {
	v = Window.new(name: "press a key to save it", bounds:Rect(500, 500,500,100)).front;
	t = StaticText(v,Rect(200,10,500,50)).string_("FM");
	v.view.keyDownAction = {
		arg view, char, modifiers, unicode, keycode;
		[char, keycode].postln;
		~keys2synth[5] = keycode;
		};
};

w.view.keyDownAction = {
	arg view, char, modifiers, unicode, keycode;
	var fm;

	if(keycode == ~keys2synth[5]){
		fm = Synth(\fm, [\fc, ~fc_temp, \amp, ~amp_fm_temp]);
	}

};


fm.mouseDownAction = {
	var fm;
	fm = Synth(\fm, [\fc, ~fc_temp, \amp, ~amp_fm_temp]);
};
fm_knobs = Array.newClear(2);

fm_knobs[0] = Knob(w,Rect(515,100,80,80));
fm_knobs[0].value = 1000/2500;
fm_knobs[0].action = {~fc_temp = fm_knobs[0].value.linlin(0, 1, 200, 2500);
						postln(~fc_temp);
					};
knob_names[5,0] =  StaticText(w,Rect(30+500,170,90,30)).string_("FC FREQ");

fm_knobs[1] = Knob(w,Rect(515,300,80,80));
fm_knobs[1].value = 0.2/3;
fm_knobs[1].action = {~amp_fm_temp = fm_knobs[1].value.linexp(0, 1, 0.01, 3);
						postln(~amp_fm_temp);
					};
knob_names[5,1] =  StaticText(w,Rect(50+500,170+200,90,30)).string_("AMP");



///////////////////////////////////// clap electro ///////////////////////////////////////
ce = Button.new(w,Rect(615,10,80,80));
ce.string = "clap electro";
buttons4keys[6] = Button.new(w,Rect(615,400,80,80));
buttons4keys[6].string = "assign";


buttons4keys[6].mouseDownAction = {
	v = Window.new(name: "press a key to save it", bounds:Rect(500, 500,500,100)).front;
	t = StaticText(v,Rect(200,10,500,50)).string_("CLAP ELECTRO");
	v.view.keyDownAction = {
		arg view, char, modifiers, unicode, keycode;
		[char, keycode].postln;
		~keys2synth[6] = keycode;
		};
};

w.view.keyDownAction = {
	arg view, char, modifiers, unicode, keycode;
	var clap_e;

	if(keycode == ~keys2synth[6]){
		clap_e = Synth(\ce, [\value, ~value_temp, \amp, ~amp_clap_e_temp]);
	}

};


ce.mouseDownAction = {
	var clap_e;
	clap_e = Synth(\ce, [\value, ~value_temp, \amp, ~amp_clap_e_temp]);
};
ce_knobs = Array.newClear(2);

ce_knobs[0] = Knob(w,Rect(615,100,80,80));
ce_knobs[0].value = 7600/9000;
ce_knobs[0].action = {~value_temp = ce_knobs[0].value.linlin(0, 1, 200, 9000);
						postln(~value_temp);
					};
knob_names[6,0] =  StaticText(w,Rect(30+600,170,90,30)).string_("VALUE FREQ");

ce_knobs[1] = Knob(w,Rect(615,300,80,80));
ce_knobs[1].value = 0.5/3.5;
ce_knobs[1].action = {~amp_clap_e_temp = ce_knobs[1].value.linexp(0, 1, 0.01, 3.5);
						postln(~amp_clap_e_temp);
					};
knob_names[6,1] =  StaticText(w,Rect(50+600,170+200,90,30)).string_("AMP");




///////////////////////////////////// tom ///////////////////////////////////////
tom = Button.new(w,Rect(715,10,80,80));
tom.string = "tom";
buttons4keys[7] = Button.new(w,Rect(715,400,80,80));
buttons4keys[7].string = "assign";


buttons4keys[7].mouseDownAction = {
	v = Window.new(name: "press a key to save it", bounds:Rect(500, 500,500,100)).front;
	t = StaticText(v,Rect(200,10,500,50)).string_("TOM");
	v.view.keyDownAction = {
		arg view, char, modifiers, unicode, keycode;
		[char, keycode].postln;
		~keys2synth[7] = keycode;
		};
};

w.view.keyDownAction = {
	arg view, char, modifiers, unicode, keycode;
	var tom;

	if(keycode == ~keys2synth[7]){
		tom = Synth(\tom, [\pitchRel, ~pitchRel_temp, \startPitch, ~startPitch_temp, \amp, ~amp_tom_temp]);
	}

};

tom.mouseDownAction = {
	var tom;
	tom = Synth(\tom, [\pitchRel, ~pitchRel_temp, \startPitch, ~startPitch_temp, \amp, ~amp_tom_temp]);
};
tom_knobs = Array.newClear(3);

tom_knobs[0] = Knob(w,Rect(715,100,80,80));
tom_knobs[0].value = 1000/3000;
tom_knobs[0].action = {~startPitch_temp = tom_knobs[0].value.linlin(0, 1, 100, 3000);
						postln(~startPitch_temp);
					};
knob_names[7,0] =  StaticText(w,Rect(30+700,170,90,30)).string_("START PITCH");

tom_knobs[1] = Knob(w,Rect(715,200,80,80));
tom_knobs[1].value = 0.11/1;
tom_knobs[1].action = {~pitchRel_temp = tom_knobs[1].value.linlin(0, 1, 0, 1);
						postln(~pitchRel_temp);
					};
knob_names[7,1] =  StaticText(w,Rect(50+700,170+100,90,30)).string_("PITCH REL");

tom_knobs[2] = Knob(w,Rect(715,300,80,80));
tom_knobs[2].value = 0.1/3;
tom_knobs[2].action = {~amp_tom_temp = tom_knobs[2].value.linexp(0, 1, 0.01, 3);
						postln(~amp_tom_temp);
					};
knob_names[7,2] =  StaticText(w,Rect(50+700,170+200,90,30)).string_("AMP");


)




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////// connection Supercollider <--> MIDI <--> JUCE/// ///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//is the JUCE midi connection ready?



MIDIClient.init;
MIDIClient.destinations;
var midiJUCE = MIDIOut.new(0);

midiJUCE.postln;


//bind juce with sc

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
//selecte a sample and play a key to assign it
var selected;
w = Window.new(name: "Drum parts mapping", bounds:Rect(100,500,400,100)).front;
~samples = Array.newClear(3);
)


////////// ---- MANUALLY MAPPING A MIDI INSTRUMENT ---- /////////////
(
//this assignment should be left to the user. it should go like this "press any key to assign it to the bass drum" and then "press any key to assign it to the snare"
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







///////////////////////////////////key input test/////////////////////////////
(
~ciccia;
w = Window.new("click the button").front;
b = Button.new(w,Rect(10,10,80,80));
b.string = "click me";
b.mouseDownAction = {
	s = Window.new("press a key to save it");
	s.view.keyDownAction = {
		arg view, char, modifiers, unicode, keycode;
		[char, keycode].postln;

		~ciccia = keycode;
		};
	s.front;
};

w.view.keyDownAction = {
	arg view, char, modifiers, unicode, keycode;

	if(keycode == ~ciccia){
		postln("wowowjdiwjw");
	}

};
)
















