/* eslint-disable max-len */
import { useBackend, useLocalState } from "../backend";
import { Box, Button, Flex, Icon, Section, Stack } from "../components";
import { Window } from "../layouts";
import { resolveAsset } from '../assets';
import { marked } from 'marked';
import { sanitizeText } from '../sanitize';
const CoolHeaderColor = 'green';
const CoolContentColor = "primary";
const CoolHeadfootHeight = "4em";
const CoolContentFontSize = "12px";
const CoolHeadFootFontSize = "14px";
const CoolContentButtonFontSize = "16px";
const CoolImageMaxWidth = "400px";
const CoolImageMaxHeight = "150px";
/**
 * There are three parts to the COOLBOOK, from top to bottom:
 * CoolBookHead - The header, which contains the return button and chapter title.
 *   The header stays at the top of the screen at all times.
 * CoolBookContent - The content, which is a scrollable section between the header and footer.
 *   The content is a fixed size, and will scroll if the content is too large.
 *   The content will not scroll if the content is too small, but it will still fill the space between the header and footer.
 * CoolBookFoot - The footer, which contains the page buttons.
 */
export const CoolBook = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Window width={400} height={600} theme="hackerman" resizable>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <CoolBookHead />
          </Stack.Item>
          <Stack.Item grow shrink>
            <Section fill scrollable>
              <CoolBookContent />
            </Section>
          </Stack.Item>
          <Stack.Item>
            <CoolBookFoot />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

// The actual content of the chapter, which is a scrollable section between the header and footer.
// The content is a fixed size, and will scroll if the content is too large.
// The content will not scroll if the content is too small, but it will still fill the space between the header and footer.
export const CoolBookContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    TopImage,
    TopImageResize,
    TopImageIsURL,
    BottomImage,
    BottomImageResize,
    BottomImageIsURL,
    IsIndex,
    PageText,
  } = data;
  const FormattedText = CoolBookFormatText(PageText);

  return (
    <Section
      overflowY="hide"
      fontSize={CoolContentFontSize}
      color={CoolContentColor}
      p="1em">
      <CoolImage Image={TopImage} StretchOrFit={TopImageResize} IsURL={TopImageIsURL} />
      <Box dangerouslySetInnerHTML={FormattedText} />
      <Box>
        {!!IsIndex && (<p><CoolBookTableOfContents /></p>)}
      </Box>
      <CoolImage Image={BottomImage} StretchOrFit={BottomImageResize} IsURL={BottomImageIsURL} />
    </Section>
  );
};

// An image, which is displayed at the top or bottom of the chapter.
// The image will be resized to fit the width of the content.
// If resize is true, the image will be scaled down to fit the height of the container.
// If resize is false, the image will be stretched to fit the entirety of the container.
const CoolImage = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Image,
    StretchOrFit,
    IsURL,
  } = props;
  let StretchFit;

  if (!Image) {
    return (null);
  }
  if (StretchOrFit === "stretch") {
    StretchFit = "cover";
  }
  else {
    StretchFit = "contain";
  }
  let ImagePath;
  if (IsURL) {
    ImagePath = Image;
  }
  else {
    // ImagePath = require("/../COOLBOOK_IMAGES/" + Image); // cursed line that turbofucks everything
    ImagePath = resolveAsset(Image);
  }
  return (
    <Box
      textAlign="center"
      height={CoolImageMaxHeight}
      width="auto">
      <Box
        as="img"
        height={CoolImageMaxHeight}
        src={ImagePath}
        alt="Imagine a cool image here!"
        width="auto"
        maxWidth="100%"
        resizeMode={StretchFit} />
    </Box>
  );
};

// Sanitizes and formats the text for the chapter.
export const CoolBookFormatText = (text, IsPlayerMade) => {
// Default values
  let coolTags = [
    'b',
    'br',
    'center',
    'code',
    'div',
    'font',
    'hr',
    'i',
    'li',
    'menu',
    'ol',
    'p',
    'pre',
    'span',
    'table',
    'td',
    'th',
    'tr',
    'u',
    'ul',
    'img', // im gonna regret this arent i
  ];
  let uncoolAttr = ['class', 'style'];

  const sanitizedText = sanitizeText(text, coolTags, uncoolAttr);
  const formattedText = marked(sanitizedText, { smartypants: true, gfm: true, tables: true, sanitize: false, breaks: true, smartLists: true });
  return { __html: formattedText };
};

// The Table of Contents, which is only shown on the index page
const CoolBookTableOfContents = (props, context) => {
  const { act, data } = useBackend(context);
  const { AllChapters } = data;

  return (
    <Section title={<center>Table of Contents</center>}>
      <Flex
        direction="column">
        {AllChapters.map((chapter) => (
          <Flex.Item grow={1} key={chapter}>
            <Button
              key={chapter}
              fluid
              fontSize="16px"
              icon="fa-solid fa-book"
              content={chapter}
              onClick={() => act("SetChapter", { Chapter2Set: chapter })} />
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};

// The top bar, which contains the return button and the chapter title
const CoolBookHead = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    IsIndex,
  } = data;

  return (
    <Section
      fluid
      height={CoolHeadfootHeight}
      color={CoolHeaderColor}
      textAlign="center"
      fontSize={CoolHeadFootFontSize}>
      <Flex direction="row">
        <Flex.Item grow={1}>
          <Box py="auto" my="auto">
            {(IsIndex
              ? <CoolBookIndexTitle />
              : <CoolBookPageTitle />)}
          </Box>
        </Flex.Item>
        <Flex.Item basis="content">
          <Button
            fluid
            fontSize={CoolContentButtonFontSize}
            icon="arrow-left"
            content="Return"
            disabled={IsIndex}
            onClick={() => act("SetChapter", { Chapter2Set: "index" })} />
        </Flex.Item>
      </Flex>
    </Section>
  );
};

// The text of the title for the index page
const CoolBookIndexTitle = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    BookTitle,
    BookAuthor,
  } = data;

  return (
    <Box
      color={CoolHeaderColor}
      textAlign="center">
      <Icon name="fa-solid fa-book" /> {BookTitle} <br />
      <Icon name="fa-solid fa-user" /> {BookAuthor}
    </Box>
  );
};
// The text of the title for the non-index page
const CoolBookPageTitle = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    CurrentChapterTitle,
  } = data;

  return (
    <Box
      color={CoolHeaderColor}
      textAlign="center">
      <Icon name="fa-solid fa-book" /> {CurrentChapterTitle}
    </Box>
  );
};

// The text of the author's name for the bottom bar
const CoolBookFootText = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    BookAuthor,
  } = data;

  return (
    <Box
      color={CoolHeaderColor}
      textAlign="center">
      <Icon name="fa-solid fa-trademark" /> {BookAuthor} 20X6
    </Box>
  );
};

// The footer, which contains the page number and the page selector buttons
const CoolBookFoot = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    PageNumber,
    PageTotal,
    CanNext,
    CanPrev,
  } = data;

  return (
    <Section
      height={CoolHeadfootHeight}
      fontSize={CoolContentButtonFontSize}
      color={CoolHeaderColor}
      align="center">
      <Box
        position="relative"
        width="fit-content">
        <Button
          height="fit-content"
          width="fit-content"
          textAlign="center"
          top="50%"
          bottom="50%"
          icon="arrow-left"
          disabled={!CanPrev}
          onClick={() => act("PrevPage")} />
        <Box
          position="relative"
          inline
          fontSize={CoolContentButtonFontSize}
          color={CoolHeaderColor}
          mx="1em"
          my="auto"
          align="center">
          {PageNumber} / {PageTotal}
        </Box>
        <Button
          height="fit-content"
          textAlign="center"
          icon="arrow-right"
          top="50%"
          bottom="50%"
          verticalAlign="middle"
          disabled={!CanNext}
          onClick={() => act("NextPage")} />
      </Box>
    </Section>
  );
};
