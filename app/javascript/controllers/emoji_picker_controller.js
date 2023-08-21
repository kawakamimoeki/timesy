import { Controller } from "@hotwired/stimulus"
import { createPopup } from '@picmo/popup-picker';

export default class extends Controller {
  static targets = ["picker", "button", "input"]

  connect() {
    this.element.picker = createPopup({
      custom: [
        { 
          emoji: 'wakaru', 
          label: 'わかる', 
          url: '/emoji/wakaru.png', 
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'kusa',
          label: '草',
          url: "/emoji/kusa.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'hee',
          label: 'へえ',
          url: "/emoji/hee.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'sorena',
          label: 'それな',
          url: "/emoji/sorena.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'benri',
          label: '便利',
          url: "/emoji/benri.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'naruhodo',
          label: 'なるほど',
          url: "/emoji/naruhodo.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'sasuga',
          label: 'さすが',
          url: "/emoji/sasuga.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'kami',
          label: '神',
          url: "/emoji/kami.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'yosasou',
          label: '良さそう',
          url: "/emoji/yosasou.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'kininaru',
          label: '気になる',
          url: "/emoji/kininaru.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'arigatougozaimasu',
          label: 'ありがとうございます',
          url: "/emoji/arigatougozaimasu.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'done',
          label: 'DONE',
          url: "/emoji/done.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'tiken',
          label: '知見',
          url: "/emoji/tiken.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'tashikani',
          label: 'たしかに',
          url: "/emoji/tashikani.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'iine',
          label: 'いいね',
          url: "/emoji/iine.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: "naisu",
          label: "ナイス",
          url: "/emoji/naisu.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: "wakaran",
          label: "わからん",
          url: "/emoji/wakaran.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: "kakkoii",
          label: "カッコイイ",
          url: "/emoji/kakkoii.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: "kawaii",
          label: "kawaii",
          url: "/emoji/kawaii.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: "kuwashii",
          label: "詳しい",
          url: "/emoji/kuwashii.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: "muzui",
          label: "むずい",
          url: "/emoji/muzui.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: "kyoumibukai",
          label: "興味深い",
          url: "/emoji/kyoumibukai.png",
          tags: [],
          data: { custom: true }
        },
      ]
    }, {
      triggerElement: this.buttonTarget,
      referenceElement: this.buttonTarget,
    });
    this.element.picker.addEventListener('emoji:select', selection => {
      this.element.picker.close();
      this.inputTarget.value = selection.data?.custom ? `<img src="${selection.url}" alt="${selection.label}" />` : selection.emoji;
      this.element.requestSubmit();
    });
  }

  open() {
    this.element.picker.open();
  }
}
