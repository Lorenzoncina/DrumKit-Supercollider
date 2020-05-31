/*
  ==============================================================================

    MySlider.h
    Created: 27 May 2020 11:41:48am
    Author:  conci

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>

//==============================================================================
/*
*/
class MySlider    : public Slider
{
public:
    MySlider()
    {   
    }

    ~MySlider()
    {
    }

	String  synth;
    String  addr;

private:
	
	

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (MySlider)
};
