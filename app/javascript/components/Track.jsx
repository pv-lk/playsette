import React from 'react'
import ReactDOM from 'react-dom'
import AudioPlayer from './AudioPlayer'
import Likes from './Likes'
import Metadata from './track/metadata'
import PlayButton from './track/play_button'
import SubmissionData from './track/submission_data'
import EmbeddingData from './track/embedding_data'

class Track extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {

    var backgroundArtStyle = {
      backgroundImage: 'url(' + this.props.albumArtPath + ')',
      backgroundPosition: 'center'
    }

    return (
      <div id={ 'track-' + this.props.track.id } className="row track">

      <div className="track-background" style={ backgroundArtStyle }>
        <div className="track-overlay">
          <AudioPlayer track={ this.props.track } embeddedService={ this.props.media.source_service } />
          <Metadata track={ this.props.track } />
          <SubmissionData userId={ this.props.track.user_id } user={ this.props.user } formattedTime={ this.props.formattedTime } />
        </div>
      </div>

        <div className="track-base col-xs-12">
          <EmbeddingData sourceService={ this.props.media.source_service } sourcePath={ this.props.media.source_path } />
          <Likes />
        </div>

      </div>
    )
  }
}

export default Track