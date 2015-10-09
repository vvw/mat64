%function:
%       基于sift特征点的人民币识别
%注意：
%      由于matlab没有自带sift特征提取，sift特征提取调用了该算法作者提供的底层调用。
%      matlab新版已集成surf特征提取，surf特征是基于sift改进的，提高了速度，但个人感觉性能有所下降。（后续有可能给出测试）
%referrence：
%      David G. Lowe，Distinctive Image Features from Scale-Invariant Keypoints
%date:2015-1-13
%author:chenyanan
%转载请注明出处：http://blog.csdn.net/u010278305

%清空变量，读取图像
clear;close all
fprintf('/******************************\n**It''s writed by chenyn2014.\n******************************/\n');

%读取object1（模板1）
object1= imread('images/object1.jpg');
object1=rgb2gray(object1);

%读取object100（模板2）
object100= imread('images/object100.jpg');
object100=rgb2gray(object100);

%读取场景(你可以自行更换场景图片进行测试)
scene= imread('images/scene100.jpg');
scene=rgb2gray(scene);

%将所有的模板放在一个元胞数组中
object_cell={object1,object100};

%与所有模板做匹配（模板遍历）
for i=1:2
    fprintf('\nobjec[ %d]\n\n',i);
    %提取第i个模板
    imwrite(object_cell{i},'tmp_images/obj_tmp.jpg');
    match_last=1;
    %从小到大缩放场景图像，找到匹配数比较适合的缩放级别（缩放遍历）
    for scale=0.1:0.1:0.5
        fprintf('\nscale[ %f]\n\n',scale);
        scene_tmp = imresize(scene, scale);
        imwrite(scene_tmp,'tmp_images/sce_tmp.jpg');
        %匹配
        [match_now,keypoint1,keypoint2]=match('tmp_images/sce_tmp.jpg','tmp_images/obj_tmp.jpg');
        %如果没有找到关键点，继续增大场景图像
        if(match_now==0)
            match_now=1;
            continue;
        end
        %如果本次增大场景图像后，本次寻得的关键点与上次比变化不大，
        %则认为上次寻找的关键点数为最终寻找到的关键点数，跳出缩放遍历
        if(match_now/match_last<1.2&&scale>=0.2)
            match_num=match_last;
            break;
        end
        match_last=match_now;
    end
    %如果寻得的匹配点数大于模板关键点数的十分之一，则认为已寻得匹配，跳出模板遍历
    if(match_num>0.1*keypoint2)
        %打印识别结果
        fprintf('\nFound objec at objec[ %d]\n',i);
        break;
    end
end

