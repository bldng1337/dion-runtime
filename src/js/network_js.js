import { fetch as internal_fetch, get_cookies as internal_getCookies } from "internal_network";
export {get_cookies as getCookies} from "internal_network";
/**
 *
 * @param {String} resource
 * @param {{}} options
 */
export async function fetch(resource, options) {
  if(!resource.startsWith("http")){
    resource = "https://" + resource;
  }
  return new Response(
    await internal_fetch(resource, { method: "GET", ...options })
  );
}

class Response {
  constructor(response) {
    this.response = response;
  }
  get status() {
    return this.response.status;
  }
  get headers() {
    return this.response.headers;
  }
  get body() {
    return this.response.body;
  }
  get json() {
    return JSON.parse(this.response.body);
  }
  get ok() {
    return this.response.ok;
  }
}
