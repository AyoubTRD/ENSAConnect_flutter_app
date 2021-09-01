import 'package:dotted_border/dotted_border.dart';
import 'package:ensa/models/story_model.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class StoryPreview extends StatelessWidget {
  const StoryPreview({
    Key? key,
    this.story,
    this.createStory = false,
  }) : super(key: key);

  final Story? story;
  final bool createStory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(50.0),
          child: DottedBorder(
            color: createStory
                ? Theme.of(context).accentColor
                : Colors.transparent,
            borderType: BorderType.Circle,
            strokeWidth: 1.5,
            dashPattern: [6.5],
            child: Container(
              margin: createStory ? const EdgeInsets.all(1.0) : null,
              height: createStory ? 65.0 - 2.0 : 65.0,
              width: createStory ? 65.0 - 2.0 : 65.0,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: createStory
                    ? Theme.of(context).accentColor.withOpacity(0.1)
                    : null,
                border: createStory
                    ? null
                    : Border.all(
                        color: Theme.of(context).accentColor,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
              ),
              child: createStory
                  ? Center(
                      child: Icon(
                        Ionicons.add_outline,
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor:
                          Theme.of(context).accentColor.withOpacity(0.1),
                      backgroundImage: NetworkImage(story!.user.profilePicture),
                    ),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          createStory ? 'Share story' : story!.user.firstName,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
