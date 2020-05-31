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
	vol1.setLookAndFeel(&otherLookAndFeel);
	

	vol2.setRange(0.0, 1.0, 0.01);
	vol2.setValue(0.5);
	vol2.setSliderStyle(Slider::SliderStyle::Rotary);
	vol2.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol2.addListener(this);
	vol2.synth = "hh";
	addAndMakeVisible(vol2);
	vol2.setLookAndFeel(&otherLookAndFeel);

	vol3.setRange(0.0, 1.0, 0.01);
	vol3.setValue(0.5);
	vol3.setSliderStyle(Slider::SliderStyle::Rotary);
	vol3.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol3.addListener(this);
	vol3.synth = "sn";
	addAndMakeVisible(vol3);
	vol3.setLookAndFeel(&otherLookAndFeel);
	
	vol4.setRange(0.0, 1.0, 0.01);
	vol4.setValue(0.5);
	vol4.setSliderStyle(Slider::SliderStyle::Rotary);
	vol4.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol4.addListener(this);
	vol4.synth = "cb";
	addAndMakeVisible(vol4);
	vol4.setLookAndFeel(&otherLookAndFeel);

	vol5.setRange(0.0, 1.0, 0.01);
	vol5.setValue(0.5);
	vol5.setSliderStyle(Slider::SliderStyle::Rotary);
	vol5.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol5.addListener(this);
	vol5.synth = "kc";
	addAndMakeVisible(vol5);
	vol5.setLookAndFeel(&otherLookAndFeel);

	vol6.setRange(0.0, 1.0, 0.01);
	vol6.setValue(0.5);
	vol6.setSliderStyle(Slider::SliderStyle::Rotary);
	vol6.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol6.addListener(this);
	vol6.synth = "fm";
	addAndMakeVisible(vol6);
	vol6.setLookAndFeel(&otherLookAndFeel);

	vol7.setRange(0.0, 1.0, 0.01);
	vol7.setValue(0.5);
	vol7.setSliderStyle(Slider::SliderStyle::Rotary);
	vol7.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol7.addListener(this);
	vol7.synth = "ce";
	addAndMakeVisible(vol7);
	vol7.setLookAndFeel(&otherLookAndFeel);

	vol8.setRange(0.0, 1.0, 0.01);
	vol8.setValue(0.5);
	vol8.setSliderStyle(Slider::SliderStyle::Rotary);
	vol8.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	vol8.addListener(this);
	vol8.synth = "tom";
	addAndMakeVisible(vol8);
	vol8.setLookAndFeel(&otherLookAndFeel);

	//Other SLiders
	slid1.setSliderStyle(Slider::SliderStyle::Rotary);
	slid1.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid1);
	slid1.setLookAndFeel(&otherLookAndFeel);

	slid2.setSliderStyle(Slider::SliderStyle::Rotary);
	slid2.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid2);
	slid2.setLookAndFeel(&otherLookAndFeel);

	slid3.setSliderStyle(Slider::SliderStyle::Rotary);
	slid3.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid3);
	slid3.setLookAndFeel(&otherLookAndFeel);

	slid4.setSliderStyle(Slider::SliderStyle::Rotary);
	slid4.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid4);
	slid4.setLookAndFeel(&otherLookAndFeel);

	slid5.setSliderStyle(Slider::SliderStyle::Rotary);
	slid5.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid5);
	slid5.setLookAndFeel(&otherLookAndFeel);

	slid6.setSliderStyle(Slider::SliderStyle::Rotary);
	slid6.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid6);
	slid6.setLookAndFeel(&otherLookAndFeel);

	slid7.setSliderStyle(Slider::SliderStyle::Rotary);
	slid7.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid7);
	slid7.setLookAndFeel(&otherLookAndFeel);

	slid8.setSliderStyle(Slider::SliderStyle::Rotary);
	slid8.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	addAndMakeVisible(slid8);
	slid8.setLookAndFeel(&otherLookAndFeel);

	//Other Elements
	startStopButton.setButtonText("Start/Stop");
	addAndMakeVisible(startStopButton);

	tempoSlider.setRange(50.0,180.0,1.0);
	tempoSlider.setSliderStyle(Slider::SliderStyle::Rotary);
	tempoSlider.setTextBoxStyle(Slider::TextEntryBoxPosition::TextBoxBelow, true, 30, 15);
	addAndMakeVisible(tempoSlider);
	tempoSlider.setLookAndFeel(&otherLookAndFeel);

	tempoLabel.setText("Tempo", dontSendNotification);
	addAndMakeVisible(tempoLabel);

	instrumentSelector.setRange(1.0, 8.0, 1.0);
	instrumentSelector.setSliderStyle(Slider::SliderStyle::Rotary);
	instrumentSelector.setTextBoxStyle(Slider::TextEntryBoxPosition::TextBoxBelow, true, 30, 15);
	addAndMakeVisible(instrumentSelector);
	instrumentSelector.setLookAndFeel(&otherLookAndFeel);

	addAndMakeVisible(slid9);
	slid9.setSliderStyle(Slider::SliderStyle::Rotary);
	slid9.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	slid9.setLookAndFeel(&otherLookAndFeel);

	addAndMakeVisible(slid10);
	slid10.setSliderStyle(Slider::SliderStyle::Rotary);
	slid10.setLookAndFeel(&otherLookAndFeel);
	slid10.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);

	addAndMakeVisible(slid11);
	slid11.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	slid11.setLookAndFeel(&otherLookAndFeel);
	slid11.setSliderStyle(Slider::SliderStyle::Rotary);

	addAndMakeVisible(slid12);
	slid12.setSliderStyle(Slider::SliderStyle::Rotary);
	slid12.setTextBoxStyle(Slider::TextEntryBoxPosition::NoTextBox, false, 0, 0);
	slid12.setLookAndFeel(&otherLookAndFeel);

	//Label
	addAndMakeVisible(volLab1);
	volLab1.setText("Vol", dontSendNotification);
	addAndMakeVisible(volLab2);
	volLab2.setText("Vol", dontSendNotification);
	addAndMakeVisible(volLab3);
	volLab3.setText("Vol", dontSendNotification);
	addAndMakeVisible(volLab4);
	volLab4.setText("Vol", dontSendNotification);
	addAndMakeVisible(volLab5);
	volLab5.setText("Vol", dontSendNotification);
	addAndMakeVisible(volLab6);
	volLab6.setText("Vol", dontSendNotification);
	addAndMakeVisible(volLab7);
	volLab7.setText("Vol", dontSendNotification);
	addAndMakeVisible(volLab8);
	volLab8.setText("Vol", dontSendNotification);

	addAndMakeVisible(tempo);
	tempo.setText("Tempo", dontSendNotification);

	addAndMakeVisible(slidLab1);
	slidLab1.setText("L1",dontSendNotification);
	slidLab1.setFont(Font(10));

	addAndMakeVisible(slidLab2);
	slidLab2.setText("Q", dontSendNotification);
	slidLab2.setFont(Font(10));

	addAndMakeVisible(slidLab3);
	slidLab3.setText("SIN_FREQ", dontSendNotification);
	slidLab3.setFont(Font(10));


	addAndMakeVisible(slidLab4);
	slidLab4.setText("FUND_FREQ", dontSendNotification);
	slidLab4.setFont(Font(10));


	addAndMakeVisible(slidLab5);
	slidLab5.setText("START_FREQ", dontSendNotification);
	slidLab5.setFont(Font(10));

	addAndMakeVisible(slidLab6);
	slidLab6.setText("FC_FREQ", dontSendNotification);
	slidLab6.setFont(Font(10));


	addAndMakeVisible(slidLab7);
	slidLab7.setText("VALUE_FREQ", dontSendNotification);
	slidLab7.setFont(Font(10));


	addAndMakeVisible(slidLab8);
	slidLab8.setText("START_PITCH", dontSendNotification);
	slidLab8.setFont(Font(10));

	addAndMakeVisible(slidLab9);
	slidLab9.setText("START", dontSendNotification);
	slidLab9.setFont(Font(10));

	addAndMakeVisible(slidLab10);
	slidLab10.setText("F_FREQ", dontSendNotification);
	slidLab10.setFont(Font(10));

	addAndMakeVisible(slidLab11);
	slidLab11.setText("F_FREQ", dontSendNotification);
	slidLab11.setFont(Font(10));

	addAndMakeVisible(slidLab12);
	slidLab12.setText("PITCH_REL", dontSendNotification);
	slidLab12.setFont(Font(10));

}

MainComponent::~MainComponent()
{

	vol1.setLookAndFeel(nullptr);
	vol2.setLookAndFeel(nullptr);
	vol3.setLookAndFeel(nullptr);
	vol4.setLookAndFeel(nullptr);
	vol5.setLookAndFeel(nullptr);
	vol6.setLookAndFeel(nullptr);
	vol7.setLookAndFeel(nullptr);
	vol8.setLookAndFeel(nullptr);

	slid1.setLookAndFeel(nullptr);
	slid2.setLookAndFeel(nullptr);
	slid3.setLookAndFeel(nullptr);
	slid4.setLookAndFeel(nullptr);
	slid5.setLookAndFeel(nullptr);
	slid6.setLookAndFeel(nullptr);
	slid7.setLookAndFeel(nullptr);
	slid8.setLookAndFeel(nullptr);
	slid9.setLookAndFeel(nullptr);
	slid10.setLookAndFeel(nullptr);
	slid11.setLookAndFeel(nullptr);
	slid12.setLookAndFeel(nullptr);

	tempoSlider.setLookAndFeel(nullptr);
	instrumentSelector.setLookAndFeel(nullptr);
}

//==============================================================================
void MainComponent::paint (Graphics& g)
{
    // (Our component is opaque, so we must completely fill the background with a solid colour)
    g.fillAll (getLookAndFeel().findColour (ResizableWindow::backgroundColourId));

    g.setFont (Font (16.0f));
    g.setColour (Colours::white);

	//Volume Label
	//g.drawText("Volume", title, Justification::centred, true);
   
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
	instrumentSelector.setBounds(instrumentSelectorRect.translated(0,30));

	//Pippoli bonus
	slid9.setBounds(areaPippoliBonus.removeFromLeft(xButton));
	slid10.setBounds(areaPippoliBonus.removeFromLeft(xButton));
	slid11.setBounds(areaPippoliBonus.removeFromLeft(xButton));
	slid12.setBounds(areaPippoliBonus.removeFromRight(xButton));

	seqPanel.setBounds(areaButtons);


	//Label
	volLab1.setBounds(135, 80, 60, 15);
	volLab2.setBounds(199, 80, 60, 15);
	volLab3.setBounds(255, 80, 60, 15);
	volLab4.setBounds(315, 80, 60, 15);
	volLab5.setBounds(375, 80, 60, 15);
	volLab6.setBounds(435, 80, 60, 15);
	volLab7.setBounds(495, 80, 60, 15);
	volLab8.setBounds(555, 80, 60, 15);

	tempo.setBounds(35, 115, 60, 15);

	slidLab1.setBounds(137, 200, 60, 15);
	slidLab2.setBounds(198, 200, 60, 15);
	slidLab3.setBounds(240, 200, 60, 15);
	slidLab4.setBounds(300, 200, 60, 15);
	slidLab5.setBounds(360, 200, 60, 15);
	slidLab6.setBounds(422, 200, 60, 15);
	slidLab7.setBounds(475, 200, 60, 15);
	slidLab8.setBounds(535, 200, 60, 15);

	slidLab9.setBounds(127, 310, 60, 15);
	slidLab10.setBounds(187, 310, 60, 15);
	slidLab11.setBounds(247, 310, 60, 15);
	slidLab12.setBounds(543, 310, 60, 15);
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