//
//  ProfileViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit

///profile viewcontroller
final class ProfileViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var userPosts = [UserPost]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureNavBar()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didtapSettingsButton))
    }
    
    @objc private func didtapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing =  1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = .init(top: 0, left: 1, bottom: 0, right: 1)
        let size = (view.width - 4)/3
        layout.itemSize = .init(width: size, height: size)
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        //cell
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.id)
        //headers
        collectionView?.register(ProfileCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: ProfileCollectionReusableView.id)
        collectionView?.register(ProfileTabsCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: ProfileTabsCollectionReusableView.id)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
 
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }else{
          //  return userPosts.count
            return 30
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          //let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.id,
                                                                      for: indexPath) as! PhotoCollectionViewCell
        //cell.backgroundColor = .systemRed
        //cell.configure(with: model)
        cell.configure(debug: "test")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //let model = userPosts[indexPath.row]
        let vc = PostViewController(model: nil)
        vc.title = "Post"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            //footer
            return UICollectionReusableView()
        }
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                            withReuseIdentifier: ProfileTabsCollectionReusableView.id,
                                            for: indexPath) as! ProfileTabsCollectionReusableView
            return header
        }
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                        withReuseIdentifier: ProfileCollectionReusableView.id,
                                        for: indexPath) as! ProfileCollectionReusableView
        profileHeader.delegate = self
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/3)
        }else{
            return CGSize(width: collectionView.width, height: 65)
        }
    }
}

extension ProfileViewController: ProfileCollectionReusableViewDelegate {
    
    func profileHeaderDidTapPostButton(_ header: ProfileCollectionReusableView) {
        //scroll to the posts
        collectionView?.scrollToItem(at: IndexPath(item: 0, section: 1),
                                     at: .top, animated: true)
    }
    func profileHeaderDidTapFollowersButton(_ header: ProfileCollectionReusableView) {
        let vc = ListViewController()
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapFollowingButton(_ header: ProfileCollectionReusableView) {
        let vc = ListViewController()
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapEditProfileButton(_ header: ProfileCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit profile"
        present(UINavigationController(rootViewController: vc),animated: true)
    }
}
