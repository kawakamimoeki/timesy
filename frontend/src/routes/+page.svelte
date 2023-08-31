<script lang="ts">
	import PostCard from '$lib/PostCard.svelte';
  import type { PageData } from './$types';
  import { onMount } from 'svelte';

  let posts: Array<Post> = [];

  onMount(async () => {
    const res = await fetch(`${data.backend}/api/v1/posts`);
	  const json = await res.json();
    posts = json.posts as Array<Post>
  });

  export let data: PageData;
</script>

<div class="flex grow relative ">
  <div class="grow w-full" id="main">
    <div id="nav-container" class="top-0 sticky z-[50]" data-turbo-permanent>
      <div class="w-full flex items-center shadow-sm font-bold dark:border-b dark:border-dark-border sticky space-x-3 z-[50] bg-white dark:bg-dark-background dark:text-gray-200 text-gray-700 mb-4 h-[40px]">
        <nav data-controller="nav">
          <a
            href="/"
            class="hover:opacity-100 py-2 text-center opacity-3 mr-5"
            data-turbo-frame="_top"
            data-nav-target="item"
            data-current="/"
          >
            Home
          </a>
          <a
            href="/latest"
            class=" mr-5 -pb-[3px]"
            data-turbo-frame="_top"
            data-nav-target="item"
            data-current="/latest"
          >
            Latest
          </a>
          <a
            href="/trending"
            class="hover:opacity-100 py-2 text-center opacity-3 mr-5"
            data-turbo-frame="_top"
            data-nav-target="item"
            data-current="/trending"
          >
            Trending
          </a>
          <a
            href="/pinned"
            class="<hover:opacity-100 py-2 text-center opacity-3 mr-5"
            data-turbo-frame="_top"
            data-nav-target="item"
            data-current="/pinned"
          >
            Pinned
          </a>
        </nav>
      </div>
    </div>
    <div class="max-w-3xl mx-auto px-4">
      <div id="post-form-container" data-turbo-permanent>
        <!-- form -->
      </div>

      {#each posts as post}
        <div class="mb-4">
          <PostCard post={post} />
        </div>
      {/each}
    </div>
  </div>
</div>
