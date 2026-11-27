import type {
	Account,
	AuthCreds,
	AuthData,
} from "@dion-js/runtime-types/runtime";
import { getAuthSecret, invalidate, isLoggedIn, mergeAuth } from "auth";
import { logerr } from "./util.js";

/** Resolves to the account's profile when the credentials are valid, or to
 * null/undefined when they are not (an empty object means valid). */
type ValidateFunc = (account: AuthAccount) => Promise<
	| {
			userName?: string;
			profilePic?: string;
	  }
	| null
	| undefined
>;

export class AuthAccount {
	domain: string;
	authType: AuthData;
	validate: ValidateFunc;

	constructor(domain: string, authType: AuthData, validate: ValidateFunc) {
		this.validate = validate;
		this.domain = domain;
		this.authType = authType;
	}

	getDefinition(): Account {
		return {
			domain: this.domain,
			auth: this.authType,
		};
	}

	async register(): Promise<void> {
		try {
			await mergeAuth(this.getDefinition());
		} catch (e) {
			logerr(
				`Error: Failed to merge auth account for domain: ${this.domain} - ${e}`,
			);
			throw e;
		}
	}

	async isLoggedIn(): Promise<boolean> {
		return await isLoggedIn(this.domain);
	}

	async invalidate(): Promise<void> {
		return await invalidate(this.domain);
	}

	async getAuthSecret(): Promise<AuthCreds | undefined> {
		try {
			return await getAuthSecret(this.domain);
		} catch (e) {
			logerr(
				`Error: Failed to get auth secret for domain: ${this.domain} - ${e}`,
			);
			return undefined;
		}
	}
}
