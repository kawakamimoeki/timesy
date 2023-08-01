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
          url: 'https://res.cloudinary.com/dw1xpb7if/image/upload/v1690762010/qlgwiofqrcjcyhobyh65.png', 
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'kusa',
          label: '草',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690762010/xlquuzni7mr044c0tbl3.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'hee',
          label: 'へえ',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690762010/i41n7d7sremt10qyks3j.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'sorena',
          label: 'それな',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690762010/ie07dwbtojr9a76zypmp.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'benri',
          label: '便利',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690762010/fqa8rr6ftdszjxsasieb.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'naruhodo',
          label: 'なるほど',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690762010/kfkzavws8hkkcgpjzjdn.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'sasuga',
          label: 'さすが',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690763099/odehmqcyunhmg2xze9my.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'kami',
          label: '神',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690764533/faec5fxpwsjjbfqptkwq.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'yosasou',
          label: '良さそう',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690764533/lh0o22z5a2h1u0ey7jch.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'kininaru',
          label: '気になる',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690764533/emyjnaugrubsqe6370tn.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'arigatougozaimasu',
          label: 'ありがとうございます',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690764533/lws6zcz0aquacrusgaa5.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'done',
          label: 'DONE',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690891926/g0ei1zg4pnx8ic7bkpdd.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'tiken',
          label: '知見',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690891954/lvttfwv0yiid5sulc06k.png",
          tags: [],
          data: { custom: true }
        },
        {
          emoji: 'tashikani',
          label: 'たしかに',
          url: "https://res.cloudinary.com/dw1xpb7if/image/upload/v1690891958/p8ihswpfuxdfdi8exce0.png",
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
