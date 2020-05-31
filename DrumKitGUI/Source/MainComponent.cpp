/*
  ==============================================================================

    This file was auto-generated!

  ==============================================================================
*/

#include "MainComponent.h"

//==============================================================================
MainComponent::MainComponent() : seqPanel(getLookAndFeel().findColour(ResizableWindow::backgroundColourId), &sender)
{
    setSize (600, 450);
	sender.connect("127.0.0.1", 57120);

	addAndMakeVisible(seqPanel);
	
	//Buttons
	/*addAndMakeVisible(butt1);
	addAndMakeVisible(butt2);
	addAndMakeVisible(butt3);
	addAndMakeVisible(butt4);
	addAndMakeVisible(butt5);
	addAndMakeVisible(butt6);
	addAndMakeVisible(butt7);
	addAndMakeVisible(butt8);*/
	

	//Volume Sliders
	vol1.setRange(0.0,1.0,0.01);
	vol1.setValue(0.5);
	vol1.setSliderStyle(Slider::SliderStyle::Rotary);
	vol1.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0,0);
	vol1.addListener(this);
	vol1.synth = "bd";
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
	vol3.addListener(this);
	vol3.synth = "sn";
	addAndMakeVisible(vol3);
	
	vol4.setRange(0.0, 1.0, 0.01);
	vol4.setValue(0.5);
	vol4.setSliderStyle(Slider::SliderStyle::Rotary);
	vol4.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol4.addListener(this);
	vol4.synth = "cb";
	addAndMakeVisible(vol4);

	vol5.setRange(0.0, 1.0, 0.01);
	vol5.setValue(0.5);
	vol5.setSliderStyle(Slider::SliderStyle::Rotary);
	vol5.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol5.addListener(this);
	vol5.synth = "kc";
	addAndMakeVisible(vol5);

	vol6.setRange(0.0, 1.0, 0.01);
	vol6.setValue(0.5);
	vol6.setSliderStyle(Slider::SliderStyle::Rotary);
	vol6.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol6.addListener(this);
	vol6.synth = "fm";
	addAndMakeVisible(vol6);

	vol7.setRange(0.0, 1.0, 0.01);
	vol7.setValue(0.5);
	vol7.setSliderStyle(Slider::SliderStyle::Rotary);
	vol7.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol7.addListener(this);
	vol7.synth = "ce";
	addAndMakeVisible(vol7);

	vol8.setRange(0.0, 1.0, 0.01);
	vol8.setValue(0.5);
	vol8.setSliderStyle(Slider::SliderStyle::Rotary);
	vol8.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol8.addListener(this);
	vol8.synth = "tom";
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

	tempoSlider.setRange(50.0,180.0,1.0);
	tempoSlider.setSliderStyle(Slider::SliderStyle::Rotary);
	tempoSlider.setTextBoxStyle(Slider::TextEntryBoxPosition::TextBoxBelow, true, 30, 15);
	addAndMakeVisible(tempoSlider);

	tempoLabel.setText("Tempo", dontSendNotification);
	addAndMakeVisible(tempoLabel);

	instrumentSelector.setRange(1.0, 8.0, 1.0);
	instrumentSelector.setSliderStyle(Slider::SliderStyle::Rotary);
	instrumentSelector.setTextBoxStyle(Slider::TextEntryBoxPosition::TextBoxBelow, true, 30, 15);
	addAndMakeVisible(instrumentSelector);

	addAndMakeVisible(slid9);
	slid9.setSliderStyle(Slider::SliderStyle::Rotary);
	slid9.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid10);
	slid10.setSliderStyle(Slider::SliderStyle::Rotary);
	slid10.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid11);
	slid11.setSliderStyle(Slider::SliderStyle::Rotary);
	slid11.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid12);
	slid12.setSliderStyle(Slider::SliderStyle::Rotary);
	slid12.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);

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
	Rectangle <int> upperPanel = area.removeFromTop(getHeight() / 2);
	Rectangle <int> lowerPanel = area.removeFromBottom(getHeight() / 2);

	Rectangle <int> firstRow = upperPanel.removeFromTop(upperPanel.getHeight() / 2);
	Rectangle <int> secondRow = upperPanel.removeFromBottom(upperPanel.getHeight() / 1);

	Rectangle <int> thirdRow = lowerPanel.removeFromTop(lowerPanel.getHeight() / 2);
	Rectangle  <int> fourthRow = lowerPanel.removeFromBottom(lowerPanel.getHeight() / 1);

	Rectangle <int> areaVolumeSliders = firstRow.removeFromRight((firstRow.getWidth() / 5) * 4);
	Rectangle <int> areaOtherSliders = secondRow.removeFromRight((secondRow.getWidth() / 5) * 4);
	Rectangle <int> areaPippoliBonus = thirdRow.removeFromRight((thirdRow.getWidth() / 5) * 4);
	Rectangle <int> areaButtons = fourthRow.removeFromRight((fourthRow.getWidth() / 5) * 4);

	/*Rectangle <int> up = area.removeFromTop((area.getHeight()/4));
	Rectangle <int> center1 = area.removeFromTop((area.getHeight() / 4) * 1);
	Rectangle <int> center2 = area.removeFromTop((area.getHeight() / 4) * 1);
	Rectangle <int> center3 = area.removeFromTop((area.getHeight() / 4));
	Rectangle <int> bottom = area.removeFromTop(area.getHeight()/ 4);

	Rectangle <int> areaVolumeSliders = up.removeFromRight((getWidth() / 10) * 8);
	Rectangle <int> areaOtherSliders = center1.removeFromRight((getWidth() / 10) * 8);
	Rectangle <int> areaPippoliBonus = center2.removeFromRight((getWidth() / 10) * 8);
	Rectangle <int> areaButtons = bottom.removeFromRight((getWidth() / 10) * 8);*/

	//Buttons
	int xButton = areaButtons.getWidth() / 8;
	int xspace = areaButtons.getWidth() / 20;/*
	butt1.setBounds(areaButtons.removeFromLeft(xButton));
	butt2.setBounds(areaButtons.removeFromLeft(xButton));
	butt3.setBounds(areaButtons.removeFromLeft(xButton));
	butt4.setBounds(areaButtons.removeFromLeft(xButton));
	butt5.setBounds(areaButtons.removeFromLeft(xButton));
	butt6.setBounds(areaButtons.removeFromLeft(xButton));
	butt7.setBounds(areaButtons.removeFromLeft(xButton));
	butt8.setBounds(areaButtons.removeFromLeft(xButton));*/

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
	startStopButton.setBounds(fourthRow.removeFromLeft(area.getWidth() / 5));
	Rectangle<int> tempoSliderRect = firstRow.removeFromLeft(area.getWidth() / 5);
	tempoSlider.setBounds(tempoSliderRect);
	//tempoLabel.setBounds(tempoSliderRect.removeFromBottom(getHeight()/3.5));

	Rectangle<int> instrumentSelectorRect = secondRow.removeFromLeft(area.getWidth() / 5);
	instrumentSelector.setBounds(instrumentSelectorRect);

	//Pippoli bonus
	slid9.setBounds(areaPippoliBonus.removeFromLeft(xButton));
	slid10.setBounds(areaPippoliBonus.removeFromLeft(xButton));
	slid11.setBounds(areaPippoliBonus.removeFromLeft(xButton));
	slid12.setBounds(areaPippoliBonus.removeFromRight(xButton));

	seqPanel.setBounds(areaButtons);
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