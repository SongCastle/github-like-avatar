# github_like_avatar
Generate a GitHub like avatar.

5 × 30|6 × 25|10 × 15
:-:|:-:|:-:
![5-30-v2](https://user-images.githubusercontent.com/47803499/156612391-106e9c01-62c1-46a9-bc4e-9afd78476b93.png)|![6-25-v2](https://user-images.githubusercontent.com/47803499/156612394-b0edac5f-c6da-41d1-90fd-bf8def74ee19.png)|![10-15-v2](https://user-images.githubusercontent.com/47803499/156612397-c705acaf-6ef9-453c-b00c-ffa4644f5eed.png)

## Requirements

- Ruby 2.0.0 or later
- [ruby-vips](https://github.com/libvips/ruby-vips) 2.0.0 or later

## How To Use

```rb
# Generate an avatar (5 × 20)
GitHubLikeAvatar.generate('avatar.png', blocks: 5, block_size: 20) do |path|
  # something like ...
  # FileUtils.cp(path, <dest_path>)
end
```

or

```rb
# Generate an avatar (10 × 15)
path = GitHubLikeAvatar.generate('avatar.png', blocks: 10, block_size: 15)
```
