/*
  ==============================================================================

    This file was auto-generated!

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>
#include "MySlider.h"
#include <math.h>
#include "OtherLookAndFeel.h"





//==============================================================================
/*
    This component lives inside our window, and this is where you should put all
    your controls and content.
*/
class MainComponent : public Component,
	public Slider::Listener,
	public Button::Listener
{
public:
	//==============================================================================
	MainComponent();
	~MainComponent();

	//==============================================================================
	void paint(Graphics&) override;
	void resized() override;

	void sendVolume(MySlider *slider);
	void sliderValueChanged(Slider *slider) override;
	void buttonClicked(Button* b) override;

private:

	struct SequencerPanel : public Component, public Button::Listener
	{
		SequencerPanel(Colour c, OSCSender* s) : backgroundColour(c), sender(s)
		{
			//sender = s;

			for (int i = 0; i < 16; ++i)
			{
				addAndMakeVisible(seqButtons.add(new TextButton()));
				seqButtons.getLast()->setClickingTogglesState(true);
				seqButtons.getLast()->setToggleState(false, dontSendNotification);
				seqButtons.getLast()->setColour(seqButtons.getLast()->buttonColourId, offColour[i / 4]);
				seqButtons.getLast()->setColour(seqButtons.getLast()->buttonOnColourId, offColour[i / 4].darker());
				seqButtons.getLast()->addListener(this);

				bdPatt.add(false);
				hhPatt.add(false);
				snPatt.add(false);
				cbPatt.add(false);
				kcPatt.add(false);
				fmPatt.add(false);
				cePatt.add(false);
				tomPatt.add(false);

			}
		}

		void paint(Graphics& g) override
		{
			g.fillAll(backgroundColour);
		}

		void resized() override
		{
			auto bounds = getLocalBounds();
			auto buttonSize = bounds.getWidth() / seqButtons.size();

			for (int i = 0; i < seqButtons.size(); ++i)
			{
				seqButtons[i]->setBounds(buttonSize * (i % seqButtons.size()),
					bounds.getHeight() / 2 - buttonSize * 0.75,
					buttonSize,
					buttonSize * 1.5);
			}
		}

		void buttonClicked(Button* b) override
		{
			OSCMessage message("/seq");
			int i = seqButtons.indexOf(static_cast<TextButton*>(b));
			
			switch (instrument)
			{
			case 1:
				bdPatt.set(i, !bdPatt[i]);
				message.setAddressPattern("/seq/bd");
				Logger::outputDebugString("Bass Drum!");
				break;
			case 2:
				hhPatt.set(i, !hhPatt[i]);
				message.setAddressPattern("/seq/hh");
				break;
			case 3:
				snPatt.set(i, !snPatt[i]);
				message.setAddressPattern("/seq/sn");
				break;
			case 4:
				cbPatt.set(i, !cbPatt[i]);
				message.setAddressPattern("/seq/cb");
				break;
			case 5:
				kcPatt.set(i, !kcPatt[i]);
				message.setAddressPattern("/seq/kc");
				break;
			case 6:
				fmPatt.set(i, !fmPatt[i]);
				message.setAddressPattern("/seq/fm");
				break;
			case 7:
				cePatt.set(i, !cePatt[i]);
				message.setAddressPattern("/seq/ce");
				break;
			case 8:
				tomPatt.set(i, !tomPatt[i]);
				message.setAddressPattern("/seq/tom");
				break;
			default:
				Logger::outputDebugString("Default!");
				break;
			}

			
			//message.addString("kick3");
			message.addInt32(i);
			message.addInt32(int(b->getToggleState()));
			if (sender->send(message)) Logger::outputDebugString("Message sent!");;
		}

		void setButtons()
		{
			Array <bool> sequence;
			switch (instrument)
			{
			case 1:
				sequence = bdPatt;
				break;
			case 2:
				sequence = hhPatt;
				break;
			case 3:
				sequence = snPatt;
				break;
			case 4:
				sequence = cbPatt;
				break;
			case 5:
				sequence = kcPatt;
				break;
			case 6:
				sequence = fmPatt;
				break;
			case 7:
				sequence = cePatt;
				break;
			case 8:
				sequence = tomPatt;
				break;
			default:
				break;
			}

			for (int i = 0; i < 16; i++)
			{
				seqButtons.getUnchecked(i)->setToggleState(sequence.getUnchecked(i), dontSendNotification);
			}
		}

		Colour backgroundColour;
		OwnedArray<TextButton> seqButtons;
		const Colour offColour[4] = { Colours::coral , Colours::orange, Colours::lightyellow, Colours::white };
		OSCSender* sender;
		Array <bool> bdPatt, hhPatt, snPatt, cbPatt, kcPatt, fmPatt, cePatt, tomPatt;
		int instrument = 1;
	};


	//TextButton butt1, butt2, butt3, butt4, butt5, butt6, butt7, butt8;
	MySlider vol1, vol2, vol3, vol4, vol5, vol6, vol7, vol8;

	MySlider slid1, slid2, slid3, slid4, slid5, slid6, slid7, slid8;

	TextButton startStopButton;
	MySlider tempoSlider, instrumentSelector;
	Label tempoLabel;
	OSCSender sender;
	MySlider slid9, slid10, slid11, slid12;
	SequencerPanel seqPanel;
	

	Label volLab1, volLab2, volLab3, volLab4, volLab5, volLab6, volLab7, volLab8;
	Label tempo;
	Label slidLab1, slidLab2, slidLab3, slidLab4, slidLab5, slidLab6, slidLab7, slidLab8, slidLab9, slidLab10, slidLab11, slidLab12;


	OtherLookAndFeel otherLookAndFeel;

	JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(MainComponent)
};

