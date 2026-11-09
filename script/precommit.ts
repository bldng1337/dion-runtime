import { $ } from "bun";

console.log("Running precommit checks...\n");

// Format code first

console.log("Formatting JavaScript/TypeScript with Biome...");
await $`biome format --write .`;

console.log("Formatting Rust with cargo fmt...");
await $`cargo fmt`;

console.log("Formatting Dart with dart format...");
const dartCwd = `${import.meta.dir}/../dart/rdion_runtime`;
await $`dart format .`.cwd(dartCwd);

console.log("Applying Dart fixes...");
await $`dart fix --apply`.cwd(dartCwd);

// Step 1: Run Biome linting (checks formatting and linting)
console.log("\n1. Running Biome check...");
await $`bunx @biomejs/biome check .`;

// Step 2: Run TypeScript type checks
console.log("\n2. Running TypeScript type checks...");
await $`bunx turbo check-types`;

// Step 3: Run turbo build (cargo tests load the bundled test extensions)
console.log("\n3. Running turbo build...");
await $`bunx turbo build`;

// Step 4: Run cargo tests
console.log("\n4. Running cargo tests...");
await $`cargo test`;

// Step 5: Check Rust formatting (fail if not formatted)
console.log("\n5. Checking Rust formatting...");
await $`cargo fmt -- --check`;

// Step 6: Run clippy with warnings as errors
console.log("\n6. Running clippy...");
await $`cargo clippy --all-targets -- -D warnings`;

// Step 7: Run bun tests
console.log("\n7. Running bun tests...");
await $`bun test`;

// Step 8: Run Flutter analyzer on dart/rdion_runtime/lib
console.log("\n8. Running Flutter analyzer...");
await $`flutter analyze lib`.cwd(dartCwd);

console.log("\n✅ All precommit checks passed!");
