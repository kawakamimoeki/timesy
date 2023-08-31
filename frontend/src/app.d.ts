// See https://kit.svelte.dev/docs/types#app
// for information about these interfaces
declare global {
	namespace App {
		// interface Error {}
		// interface Locals {}
		// interface PageData {}
		// interface Platform {}
	}

	type User = {
		username: string;
		name: string;
		avatar_icon: string;
	};
	type Post = {
		user: User;
		created_at: Date;
		html: string;
	};
}

export {};
