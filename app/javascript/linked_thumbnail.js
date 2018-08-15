export default class LinkedThumbnail {
  constructor(title, id, type, anchorPath) {
    this.title = title;
    this.id = id;
    this.type = type;
    this.anchorPath = anchorPath;
    this.toHtml = this.toHtml.bind(this);
    this.thumbnail = this.thumbnail.bind(this);
  }

  toHtml() {
   return [
      `${this.recordLink('thumbnail', this.thumbnail())}`,
      `${this.recordLink(this.title, this.title)}`,
    ].join(' ');
  }

  recordLink(alt, data) {
    return `<a href="/catalog/${this.id}#${this.anchorPath}?pn=false" alt="${alt}" class="map-pin-link">${data}</a>`;
  }

  thumbnail() {
    return `<div><img alt="${this.title}" src="/thumbnails/${this.id}/${this.type}" /></div>`;
  }
}
