import { BACKEND } from '$env/static/private';

export const load = async () => {
	return {
		backend: BACKEND
	};
};
