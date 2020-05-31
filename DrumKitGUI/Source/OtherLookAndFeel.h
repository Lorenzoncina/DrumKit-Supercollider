/*
  ==============================================================================

    OtherLookAndFeel.h
    Created: 31 May 2020 9:15:31pm
    Author:  conci

  ==============================================================================
*/

#include <JuceHeader.h>

#pragma once
class OtherLookAndFeel : public LookAndFeel_V4
{
public:
	void drawRotarySlider(Graphics &g, int x, int y, int width, int height, float sliderPos, float rotaryStartAngle, float rotaryEndAngle, Slider &slider) override
	{
		float shadowThickness = 5;
		float diameter = jmin(width, height) - shadowThickness;
		float radius = diameter / 2;
		float centreX = x + width / 2;
		float centreY = y + height / 2;
		float rx = centreX - radius;
		float ry = centreY - radius;
		float angle = rotaryStartAngle + (sliderPos*(rotaryEndAngle - rotaryStartAngle));


		Rectangle<float> dialArea(rx, ry, diameter , diameter );

		g.setColour(Colours::slategrey);
		//g.drawRect(dialArea);
		g.fillEllipse(dialArea);

		g.setColour(Colours::blanchedalmond);
		//g.fillEllipse(centreX, centreY, 5, 5);

		Path dialTick;
		dialTick.addRectangle(0, -radius, 5.0, radius / 3);

		g.fillPath(dialTick, AffineTransform::rotation(angle).translated(centreX, centreY));

		g.setColour(Colours::darkslategrey);
		g.drawEllipse(rx, ry, diameter, diameter, shadowThickness);
	};
};