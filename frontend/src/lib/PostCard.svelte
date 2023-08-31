<script lang="ts">
  export let post: Post;
</script>

<div class="relative bg-white p-4 dark:text-gray-200 dark:bg-dark-card dark:border dark:border-dark-border  transition-all animate-fade-in">
  <div class="mb-4">
    <div class="flex flex-col-reverse sm:flex-row mb-3 items-start space-x-1">
      <div class="flex items-center space-x-1 flex-wrap">
        <a href="/{post.user.username}" class="cursor-pointer text-sm flex items-center hover:underline flex-wrap">
          <img src={post.user.avatar_icon} alt="" width="20px" height="20px" class="w-8 h-8 rounded-full mr-2 block">
          <span class="mr-1 font-bold">{post.user.name}</span>
          <span class="text-gray-400">@{post.user.username}</span>
        </a>
        <time class="text-gray-400 text-sm">post.created_at</time>
      </div>
      <div class="grow flex items-center space-x-1 w-full sm:w-auto">
        <div class="grow"></div>
        <button class="block rounded-full hover:shadow-sm transition-all text-lg text-gray-600 dark:text-gray-300 cursor-pointer p-relative p-2 hover:bg-gray-50 dark:hover:bg-gray-700">
          <div class="i-lucide-copy"></div>
        </button>
        <button class="block rounded-full hover:shadow-sm transition-all text-lg text-gray-600 dark:text-gray-300 cursor-pointer p-relative p-2 hover:bg-gray-50 dark:hover:bg-gray-700">
          <div class="i-lucide-link"></div>
        </button>
      </div>
    </div>
    <div class="markdown-body">
      {@html post.html}
    </div>
  </div>
  <div class="flex items-end">
    <div class="flex grow items-center flex-wrap w-[calc(100%-40px)]">
      <div class="flex items-center flex-wrap overflow-hidden">
      </div>
      <div class="flex items-center">
        <div class="<%= indicator_class %>">
          <span class="i-lucide-server mr-1"></span>
        </div>
          <div class="<%= indicator_class %>">
            <span class="i-lucide-message-circle mr-1"></span>
          </div>
      </div>
    </div>
      <div class="i-lucide-arrow-right"></div>
  </div>
</div>
