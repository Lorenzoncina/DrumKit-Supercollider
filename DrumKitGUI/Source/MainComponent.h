/*
  ==============================================================================

    This file was auto-generated!

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>
#include "MySlider.h"

//==============================================================================
/*
    This component lives inside our window, and this is where you should put all
    your controls and content.
*/
class MainComponent   : public Component,
						public Slider::Listener
{
public:
    //==============================================================================
    MainComponent();
    ~MainComponent();

    //==============================================================================
    void paint (Graphics&) override;
    void resized() override;

	void sendVolume(MySlider *slider);
	void sliderValueChanged(Slider *slider) override;

private:
   
	TextButton butt1, butt2, butt3, butt4, butt5, butt6, butt7, butt8;
	MySlider vol1, vol2, vol3, vol4, vol5, vol6, vol7, vol8;
	
	Slider slid1, slid2, slid3, slid4, slid5, slid6, slid7, slid8;

	TextButton startStopButton;
	Slider tempoSlider, instrumentSelector;
	Label tempoLabel;
	OSCSender sender;
	MySlider slid9, slid10, slid11;


    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (MainComponent)
};
