/*
  ==============================================================================

    This file was auto-generated!

  ==============================================================================
*/

#include "MainComponent.h"

//==============================================================================
MainComponent::MainComponent()
{
    setSize (600, 450);
	sender.connect("127.0.0.1", 57120);
	//Buttons
	addAndMakeVisible(butt1);
	addAndMakeVisible(butt2);
	addAndMakeVisible(butt3);
	addAndMakeVisible(butt4);
	addAndMakeVisible(butt5);
	addAndMakeVisible(butt6);
	addAndMakeVisible(butt7);
	addAndMakeVisible(butt8);

	//Volume Sliders
	vol1.setRange(0.0,1.0,0.01);
	vol1.setValue(0.5);
	vol1.setSliderStyle(Slider::SliderStyle::Rotary);
	vol1.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0,0);
	vol1.addListener(this);
	vol1.synth = "sn";
	addAndMakeVisible(vol1);
	

	vol2.setRange(0.0, 1.0, 0.01);
	vol2.setValue(0.5);
	vol2.setSliderStyle(Slider::SliderStyle::Rotary);
	vol2.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol2.addListener(this);
	vol2.synth = "hh";
	addAndMakeVisible(vol2);

	vol3.setRange(0.0, 1.0, 0.01);
	vol3.setValue(0.5);
	vol3.setSliderStyle(Slider::SliderStyle::Rotary);
	vol3.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(vol3);
	
	vol4.setRange(0.0, 1.0, 0.01);
	vol4.setValue(0.5);
	vol4.setSliderStyle(Slider::SliderStyle::Rotary);
	vol4.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(vol4);

	vol5.setRange(0.0, 1.0, 0.01);
	vol5.setValue(0.5);
	vol5.setSliderStyle(Slider::SliderStyle::Rotary);
	vol5.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(vol5);

	vol6.setRange(0.0, 1.0, 0.01);
	vol6.setValue(0.5);
	vol6.setSliderStyle(Slider::SliderStyle::Rotary);
	vol6.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(vol6);

	vol7.setRange(0.0, 1.0, 0.01);
	vol7.setValue(0.5);
	vol7.setSliderStyle(Slider::SliderStyle::Rotary);
	vol7.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(vol7);

	vol8.setRange(0.0, 1.0, 0.01);
	vol8.setValue(0.5);
	vol8.setSliderStyle(Slider::SliderStyle::Rotary);
	vol8.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(vol8);

	//Other SLiders
	slid1.setSliderStyle(Slider::SliderStyle::Rotary);
	slid1.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid1);

	slid2.setSliderStyle(Slider::SliderStyle::Rotary);
	slid2.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid2);

	slid3.setSliderStyle(Slider::SliderStyle::Rotary);
	slid3.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid3);

	slid4.setSliderStyle(Slider::SliderStyle::Rotary);
	slid4.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid4);

	slid5.setSliderStyle(Slider::SliderStyle::Rotary);
	slid5.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid5);

	slid6.setSliderStyle(Slider::SliderStyle::Rotary);
	slid6.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid6);

	slid7.setSliderStyle(Slider::SliderStyle::Rotary);
	slid7.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid7);

	slid8.setSliderStyle(Slider::SliderStyle::Rotary);
	slid8.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid8);

	//Other Elements
	startStopButton.setButtonText("Start/Stop");
	addAndMakeVisible(startStopButton);

	tempoSlider.setRange(1.0,10.0,1.0);
	tempoSlider.setSliderStyle(Slider::SliderStyle::Rotary);
	tempoSlider.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(tempoSlider);

	tempoLabel.setText("Tempo", dontSendNotification);
	addAndMakeVisible(tempoLabel);

	instrumentSelector.setRange(1.0, 8.0, 1.0);
	instrumentSelector.setSliderStyle(Slider::SliderStyle::Rotary);
	instrumentSelector.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(instrumentSelector);


}

MainComponent::~MainComponent()
{
}

//==============================================================================
void MainComponent::paint (Graphics& g)
{
    // (Our component is opaque, so we must completely fill the background with a solid colour)
    g.fillAll (getLookAndFeel().findColour (ResizableWindow::backgroundColourId));

    g.setFont (Font (16.0f));
    g.setColour (Colours::white);
   
}

void MainComponent::resized()
{

	Rectangle <int> area = getLocalBounds();
	Rectangle <int> up = area.removeFromTop((area.getHeight()/4));
	Rectangle <int> center1 = area.removeFromTop((area.getHeight() / 3) * 2);
	Rectangle <int> center2 = area.removeFromTop((area.getHeight() / 3) * 2);
	Rectangle <int> bottom = area.removeFromBottom(area.getHeight()/3);

	Rectangle <int> areaButtons = center2.removeFromRight((getWidth() / 10) * 8);
	Rectangle <int> areaVolumeSliders = up.removeFromRight((getWidth() / 10) * 8);
	Rectangle <int> areaOtherSliders = center1.removeFromRight((getWidth() / 10) * 8);

	//Buttons
	int xButton = areaButtons.getWidth() / 8;
	int xspace = areaButtons.getWidth() / 20;
	butt1.setBounds(areaButtons.removeFromLeft(xButton));
	butt2.setBounds(areaButtons.removeFromLeft(xButton));
	butt3.setBounds(areaButtons.removeFromLeft(xButton));
	butt4.setBounds(areaButtons.removeFromLeft(xButton));
	butt5.setBounds(areaButtons.removeFromLeft(xButton));
	butt6.setBounds(areaButtons.removeFromLeft(xButton));
	butt7.setBounds(areaButtons.removeFromLeft(xButton));
	butt8.setBounds(areaButtons.removeFromLeft(xButton));

	//Volume Sliders
	int xSlider = areaVolumeSliders.getWidth() / 8;
	vol1.setBounds(areaVolumeSliders.removeFromLeft(xSlider));
	vol2.setBounds(areaVolumeSliders.removeFromLeft(xSlider));
	vol3.setBounds(areaVolumeSliders.removeFromLeft(xSlider));
	vol4.setBounds(areaVolumeSliders.removeFromLeft(xSlider));
	vol5.setBounds(areaVolumeSliders.removeFromLeft(xSlider));
	vol6.setBounds(areaVolumeSliders.removeFromLeft(xSlider));
	vol7.setBounds(areaVolumeSliders.removeFromLeft(xSlider));
	vol8.setBounds(areaVolumeSliders.removeFromLeft(xSlider));

	//Other Slider
	int xOtherSlider = areaOtherSliders.getWidth() / 8;
	slid1.setBounds(areaOtherSliders.removeFromLeft(xOtherSlider));
	slid2.setBounds(areaOtherSliders.removeFromLeft(xOtherSlider));
	slid3.setBounds(areaOtherSliders.removeFromLeft(xOtherSlider));
	slid4.setBounds(areaOtherSliders.removeFromLeft(xOtherSlider));
	slid5.setBounds(areaOtherSliders.removeFromLeft(xOtherSlider));
	slid6.setBounds(areaOtherSliders.removeFromLeft(xOtherSlider));
	slid7.setBounds(areaOtherSliders.removeFromLeft(xOtherSlider));
	slid8.setBounds(areaOtherSliders.removeFromLeft(xOtherSlider));

	//Ohter elemets
	startStopButton.setBounds(center2.removeFromLeft(getWidth() / 7));
	Rectangle<int> tempoSliderRect = center1.removeFromLeft(getWidth() / 7);
	tempoSlider.setBounds(tempoSliderRect);
	tempoLabel.setBounds(tempoSliderRect.removeFromBottom(getHeight()/3.5));

	Rectangle<int> instrumentSelectorRect = up.removeFromLeft(getWidth() / 7);
	instrumentSelector.setBounds(instrumentSelectorRect);
}


void MainComponent::sendVolume(MySlider *slider)
{	 
	float volume = slider->getValue();
	sender.send("/amp" , volume, slider->synth);
}

void MainComponent::sliderValueChanged(Slider *slider)
{	
	//sendVolume(slider->getValue(), slider->synth );
	sendVolume((MySlider*)slider);
}