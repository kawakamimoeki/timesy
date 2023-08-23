import { Application } from "@hotwired/stimulus"
import CodeBlockController from "./code_block_controller"
import CopyController from "./copy_controller"
import EmojiPickerController from "./emoji_picker_controller"
import FileFieldController from "./file_field_controller"
import ImageModalController from "./image_modal_controller"
import MarkdownController from "./markdown_controller"
import MenuController from "./menu_controller"
import NotificationController from "./notification_controller"
import PostShowController from "./post_show_controller"
import ThemeController from "./theme_controller"
import ThreadScrollController from "./thread_scroll_controller"
import TobottomController from "./tobottom_controller"
import TooltipController from "./tooltip_controller"
import TurboFormController from "./turbo_form_controller"
import TwitterController from "./twitter_controller"
import CheersController from "./cheers_controller"
import NavController from "./nav_controller"

const application = Application.start()

application.register("code-block", CodeBlockController)
application.register("copy", CopyController)
application.register("emoji-picker", EmojiPickerController)
application.register("file-field", FileFieldController)
application.register("image-modal", ImageModalController)
application.register("markdown", MarkdownController)
application.register("menu", MenuController)
application.register("notification", NotificationController)
application.register("post-show", PostShowController)
application.register("theme", ThemeController)
application.register("thread-scroll", ThreadScrollController)
application.register("tobottom", TobottomController)
application.register("tooltip", TooltipController)
application.register("turbo-form", TurboFormController)
application.register("twitter", TwitterController)
application.register("cheers", CheersController)
application.register("nav", NavController)
