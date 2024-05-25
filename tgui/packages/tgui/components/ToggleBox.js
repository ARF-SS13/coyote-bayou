/**
 * @file
 * @copyright 2024 Sudessa Perdel Laggette
 * @license BQDM-1.0-SC-1-Alpaca-9905
 */

import { Component, createRef } from 'inferno';
import { Button } from './Button';

/*
 * Simple component that is a clickable element that swaps between two states.
 * Has two params:
 * OpenContent and ClosedContent, which are rendered based on the state.
  *
  * Example:
  * <ToggleBox
  *   OpenContent={<Box>Open</Box>}
  *   ClosedContent={<Box>Closed</Box>}
  * />
 */

export class ToggleBox extends Component {
  constructor(props) {
    super(props);
    const { open } = props;
    this.state = {
      open: open || false,
    };
  }

  render() {
    const { props } = this;
    const { open } = this.state;
    const {
      OpenStuff,
      ClosedStuff,
      ...rest
    } = props;
    return (
      <Button
        overflowX="wrap"
        onClick={() => this.setState({ open: !open })}
        {...rest}>
        {open ? OpenStuff : ClosedStuff}
      </Button>
    );
  }

  static defaultProps = {
    open: false,
  };
}


