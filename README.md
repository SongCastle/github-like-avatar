# github-like-avatar
Generate GitHub like avatar.

|5 × 30|6 × 25|10 × 15|
|:-:|:-:|:-:|
|![5-30](https://user-images.githubusercontent.com/47803499/156241136-cc2f04e7-ea72-41d4-9a55-58d1a2874d53.png)|![6-25](https://user-images.githubusercontent.com/47803499/156241634-90c0c019-330e-41c1-85cd-10ea77665550.png)|![10-15](https://user-images.githubusercontent.com/47803499/156241101-2c65e612-b744-4311-b4e1-fe17667e0eb8.png)|

## Requirements

- Ruby 2.0.0 or later
- [ruby-vips](https://github.com/libvips/ruby-vips) 2.0.0 or later

## How To Use

```rb
# Generate a avatar (5 × 20)
GitHubLikeAvatar.generate('avatar.png', blocks: 5, block_size: 20) do |path|
  # something like ...
  # FileUtils.cp(path, <dest_path>)
end
```

or

```rb
# Generate a avatar (10 × 15)
path = GitHubLikeAvatar.generate('avatar.png', blocks: 10, block_size: 15)
```
